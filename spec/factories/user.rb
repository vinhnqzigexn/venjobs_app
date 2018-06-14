FactoryGirl.define do
  factory :user, class: 'User' do
    name                Faker::Name.name
    prefix              Faker::Name.prefix
    phone               '123-456-7890'
    registration        true
    email               Faker::Internet.email
    password                'password'
    password_confirmation   'password'
  end
end