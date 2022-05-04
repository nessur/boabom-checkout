class CreateJoinTableCourseSubscriptionOrder < ActiveRecord::Migration[5.0]
  def change
    create_join_table :course_subscriptions, :orders do |t|
      t.index [:course_subscription_id, :order_id], name: 'idx_course_sub_order'
      t.index [:order_id, :course_subscription_id], name: 'idx_order_course_sub'
    end
  end
end
