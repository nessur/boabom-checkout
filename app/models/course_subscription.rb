class CourseSubscription < ApplicationRecord
	belongs_to :boabom_course
	belongs_to :user
end
