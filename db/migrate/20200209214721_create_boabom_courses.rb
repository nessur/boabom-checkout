class CreateBoabomCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :boabom_courses do |t|
      t.string :name
      t.string :kind_of_class
      t.numeric :amount

      t.timestamps
    end
  end
end
