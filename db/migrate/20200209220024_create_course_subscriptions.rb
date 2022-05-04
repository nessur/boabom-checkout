class CreateCourseSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :course_subscriptions do |t|
      t.integer :user_id
      t.integer :boabom_course_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
