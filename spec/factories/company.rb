FactoryGirl.define do
  factory :company do
    name                  Faker::Company.name
    description           Faker::Lorem.paragraph
    address               Faker::Address.street_address
    email                 Faker::Internet.email
    phone                 '123-456-7890' #Faker::PhoneNumber.phone_number
    fax                   '123-456-7890' #Faker::PhoneNumber.phone_number
    number_of_employees   '1000 - 2000'
  end
end
