class CourseSubscriptionsOrder < ApplicationRecord
	belongs_to :course_subscription
	belongs_to :order
end
