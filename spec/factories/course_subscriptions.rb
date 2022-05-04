FactoryBot.define do
  factory :course_subscription do
    user_id { 1 }
    baobom_course_id { 1 }
    start_date { "2020-02-09" }
    end_date { "2020-02-09" }
  end
end
