namespace :importdb do
  require 'pry'
  require 'json'
  require 'redis'
  require 'csv'
  require 'yaml'

  desc 'import data to cities table'
  task cities: :environment do
    provs = Redis.new
    provs_hash_arr = provs.smembers 'cities'
    provs_hash = JSON.parse(provs_hash_arr[0])
    provs_hash.each do |code, prov|
      City.create!( name:           prov['name'],
                    slug:           prov['slug'],
                    city_type:      prov['type'],
                    name_with_type: prov['name_with_type'],
                    code:           prov['code'])
    end
  end


  desc 'import data to companies table'
  task companies: :environment do
    Company.create!(
      name:                  Faker::Company.name,
      description:           Faker::Lorem.paragraph,
      address:               Faker::Address.street_address,
      email:                 Faker::Internet.email,
      phone:                 '123-456-7890',
      fax:                   '123-456-7890',
      number_of_employees:   '1000 - 2000'
    )
  end

  desc 'seed industries data'
  task industries: :environment do
    path = Rails.root.join('db', 'industries.csv')
    CSV.foreach(path) do |csv|
      Industry.create(
        name: csv[1]
      )
    end
  end

  desc 'seed jobs data'
  task jobs: :environment do
    jobs_redis = Redis.new
    jobs_yaml_arr = jobs_redis.smembers 'crawled'
    jobs_yaml_arr.each do |row|
      job = YAML.load(row)
       next if job[1].blank? || !!Job.find_by(title: job[1]) || !!Job.find_by(link: job[14])
       Job.create!(
        title: job[1],
        company_id: 1,
        city_id: 1,
        industry_id: 1,
        position: 'NA',
        salary: '1_000',
        expiry_date: Time.now,
        description: 'NA',
        update_date: Time.now,
        published: true,
        welfare: 'NA',
        condition: 'NA',
        link: job[14],
       )
    end
  end
end
