FactoryGirl.define do
  factory :job do
    title         Faker::Lorem.sentence
    company_id    1
    city_id       1
    industry_id   1
    position      Faker::Lorem.word
    salary        Faker::Number.decimal(5, 2)
    expiry_date   1.month.from_now
    description   Faker::Lorem.paragraph
    update_date   Time.now
    published     Faker::Boolean.boolean
    welfare       Faker::Lorem.paragraph
    condition     Faker::Lorem.paragraph
  end
end