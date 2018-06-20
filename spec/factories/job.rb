FactoryGirl.define do
  factory :job do
    title         Faker::Lorem.sentence
    position      Faker::Lorem.word
    salary        Faker::Number.decimal(5, 2)
    expiry_date   1.month.from_now
    description   Faker::Lorem.paragraph
    update_date   Time.now
    published     true
    welfare       Faker::Lorem.paragraph
    condition     Faker::Lorem.paragraph
    link          Faker::Internet.url
  end
end
