# frozen_string_literal: true

namespace :importdb do
  require 'pry'
  require 'json'
  require 'redis'
  require 'csv'
  require 'yaml'

  desc 'import data to cities table'
  task cities: :environment do
    city_redis = Redis.new
    city_yaml_arr = city_redis.smembers('cities')
    city_yaml_arr.each do |row|
      city  = YAML.safe_load(row)
      next if City.find_by(name: city[1])
      City.create!( code: city[0],
                    name: city[1],
                    slug: city[2])
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
  inds_redis = Redis.new
  inds_yaml_arr = inds_redis.smembers('industry')
  inds_yaml_arr.each do |row|
    ind  = YAML.safe_load(row)
    next if Industry.find_by(name: ind[1])
    Industry.create!( code: ind[0],
                      name: ind[1],
                      slug: ind[2] )
    end
  end

  desc 'seed jobs data'
  task jobs: :environment do
    jobs_redis = Redis.new
    jobs_yaml_arr = jobs_redis.smembers 'crawled'
    jobs_yaml_arr.each_with_index do |row,id|
      # break if id == 3
      job = YAML.safe_load(row)
      next if job[1].blank? || !!Job.find_by(title: job[1]) || !!Job.find_by(link: job[14])
      job_new = Job.create!(
                  title: job[1],
                  company_id: 1,
                  position: 'NA',
                  salary: '1_000',
                  expiry_date: Time.now,
                  description: 'NA',
                  update_date: Time.now,
                  published: true,
                  welfare: 'NA',
                  condition: 'NA',
                  link: job[14]
                )
      # import job industry
      industry_arr = job[5].split('+').map { |ind| ind.strip }
      if industry_arr.any?
        industry_arr.each do |ind|
          ind_id = Industry.find_by(name: ind).id || Industry.first.id
          job_new.industries_jobs.create!(industry_id: ind_id)
        end
      else
        job_new.industries_jobs.create!(industry_id: City.first.id)
      end

      # import job industry
      city_arr = job[3].split(',').map { |city| city.strip }
      if city_arr.any?
        city_arr.each do |city|
          city_id = City.find_by(name: city).id || City.first.id
          job_new.cities_jobs.create!(city_id: city_id)
        end
      else
        job_new.cities_jobs.create!(city_id: City.first.id)
      end
    end
  end
end
