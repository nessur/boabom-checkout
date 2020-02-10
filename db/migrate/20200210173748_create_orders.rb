class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.boolean :paid
      t.datetime :paid_at
      t.integer :payment_month
      t.boolean :emailed

      t.timestamps
    end
  end
end
