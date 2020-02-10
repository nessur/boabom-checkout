FactoryBot.define do
  factory :payment do
    order { nil }
    amount { "" }
    stripe_id { "MyString" }
  end
end
