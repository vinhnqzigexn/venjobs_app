class JobsController < ApplicationController
  def index
    @jobs = Job.search(params[:search]).order('created_at DESC').page(params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end

  def city
    @cities = City.all.select { |city| city.jobs.any? }
  end

  def jobs_in_city
    @city = City.find_by(slug: params[:slug])
    @jobs = get_jobs_in_city(@city.id).page(params[:page])
  end

  def home
    @jobs = Job.all.order(updated_at: :desc).take(5)
    @cities = City.all.select{ |city| city.jobs.any? }.take(8)
  end

  def get_jobs_in_city(city_id)
    Job.where(city_id: city_id)
  end
end
