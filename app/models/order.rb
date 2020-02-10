class Order < ApplicationRecord
  belongs_to :user
  has_many :course_subscriptions_orders
  has_many :course_subscriptions, through: :course_subscriptions_orders
  has_many :boabom_courses, through: :course_subscriptions
  has_many :payments

  def total_order
  	boabom_courses.sum(:amount)
  end

  def discounted_total_order
  	course_subscriptions.sum do |cs|
	   cs.boabom_course.amount - (cs.boabom_course.amount * ((cs.discount || 0)/100.0))
  	end
  end
end
