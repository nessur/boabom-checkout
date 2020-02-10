class CourseSubscription < ApplicationRecord
    belongs_to :boabom_course
    belongs_to :user

    def amount
        boabom_course.amount
    end

    def discounted_amount
        boabom_course.amount - (boabom_course.amount * ((discount || 0)/100.0))
    end
end
