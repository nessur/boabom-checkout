class AddDiscountToCourseSubscription < ActiveRecord::Migration[5.0]
  def change
  	add_column :course_subscriptions, :discount, :decimal
  end
end
