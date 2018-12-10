FactoryBot.define do
  factory :plan do
    title { "MyString" }
    since_date { "2018-12-10" }
    to_date { "2018-12-10" }
    goal { 1.5 }
    user_id { 1 }
  end
end
