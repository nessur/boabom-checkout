class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
    @customers = @users.map(&:customer_id).compact.map{|id|
      Stripe::Customer.retrieve(id)
    }.index_by(&:id)

    @subscriptions = @customers.keys.map {|customer|
      Stripe::Subscription.list(customer: customer).data
    }.flatten.group_by(&:customer)
    
  end

  def show
    @user = User.find(params[:id])
    @customer = 
      begin 
        Stripe::Customer.retrieve(@user.customer_id) if @user.customer_id
      rescue Stripe::InvalidRequestError => ex
        logger.error("Customer not found for #{@user.customer_id}")
      end

    @subscriptions = 
      begin 
        Stripe::Subscription.list(customer: @user.customer_id) if @user.customer_id
      rescue Stripe::InvalidRequestError => ex
        logger.error("Subscriptions not found for Stripe ID #{@user.customer_id}")
      end

    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
