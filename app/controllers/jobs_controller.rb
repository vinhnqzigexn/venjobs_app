# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    search_str = params[:search].blank? ? '*' : params[:search]
    job_found = Job.search(kw: search_str, page: params[:page].to_i)
    job_ids = job_found[:job_id]
    @job_num = job_found[:num]
    job_search_result = Job.where(id: job_ids)
    @jobs = Kaminari.paginate_array(job_search_result, total_count: @job_num)
                    .page(params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end

  def city
    @cities = City.all.select { |city| city.jobs.any? }
  end

  def jobs_in_city
    @city = City.find_by(slug: params[:slug])
    @jobs = @city.jobs.page(params[:page])
  end

  def home
    @jobs = Job.all.order(updated_at: :desc).take(5)
    @cities = City.all.select { |city| city.jobs.any? }.take(8)
  end
end
