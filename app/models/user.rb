class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_create :pay_with_card, unless: Proc.new { |user| user.admin? }
  after_create :sign_up_for_mailing_list

  has_many :course_subscriptions
  has_many :boabom_courses, through: :course_subscriptions
  has_many :orders

  attr_accessor :stripeToken

  def courses_total
    boabom_courses.sum(:amount)
  end

  def discounted_total
    course_subscriptions.sum do |cs|
      cs.boabom_course.amount - (cs.boabom_course.amount * ((cs.discount || 0)/100.0))
    end
  end

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def pay_with_card
    if self.stripeToken.nil?
      self.errors[:base] << 'Could not verify card.'
      raise ActiveRecord::RecordInvalid.new(self)
    end

    customer = if self.customer_id
      Stripe::Customer.retrieve(self.customer_id)
    else
      Stripe::Customer.create(
        :email => self.email,
        :card  => self.stripeToken,
        name: self.name
      )
    end

    unless self.customer_id
      self.customer_id = customer.id
    end

    price = Rails.application.secrets.product_price
    title = Rails.application.secrets.product_title

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => "#{price}",
      :description => "#{title}",
      :currency    => 'usd',
      receipt_email: self.email
    )
    Rails.logger.info("Stripe transaction for #{self.email}") if charge[:paid] == true
  rescue Stripe::InvalidRequestError => e
    self.errors[:base] << e.message
    raise ActiveRecord::RecordInvalid.new(self)
  rescue Stripe::CardError => e
    self.errors[:base] << e.message
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def sign_up_for_mailing_list
    MailingListSignupJob.perform_later(self)
  end

  def subscribe
    # mailchimp = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
    # list_id = Rails.application.secrets.mailchimp_list_id
    # result = mailchimp.lists(list_id).members.create(
    #   body: {
    #     email_address: self.email,
    #     status: 'subscribed'
    # })
    # Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end

end
