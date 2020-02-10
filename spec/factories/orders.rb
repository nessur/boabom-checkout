FactoryBot.define do
  factory :order do
    user { nil }
    paid { false }
    paid_at { "2020-02-10 12:37:48" }
    payment_month { 1 }
    emailed { false }
  end
end
