class AddPaymentDayToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :payment_day, :integer
  end
end
