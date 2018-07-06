# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Company.create!(
#       name:                  Faker::Company.name,
#       description:           Faker::Lorem.paragraph,
#       address:               Faker::Address.street_address,
#       email:                 Faker::Internet.email,
#       phone:                 '123-456-7890', #Faker::PhoneNumber.phone_number,
#       fax:                   '123-456-7890', #Faker::PhoneNumber.phone_number,
#       number_of_employees:   '1000 - 2000'
#     )

(1..10).each do |i|
  user = User.create( name: Faker::Internet.user_name,
                      email: Faker::Internet.email,
                      password:              'password',
                      password_confirmation: 'password',
                    )

  (1..100).each do |j|

    job = Job.find(j)
    next if job.nil?
    Entry.create(
      job_id: job.id,
      user_id: user.id,
      entry_name: user.name,
      entry_email: user.email,
      city: job.cities.map(&:id).reject(&:blank?).join(', '),
      industry: job.industries.map(&:id).reject(&:blank?).join(', ')
    )
  end
end
