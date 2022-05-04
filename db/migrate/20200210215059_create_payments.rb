class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :order, foreign_key: true
      t.numeric :amount
      t.string :stripe_id

      t.timestamps
    end
  end
end
