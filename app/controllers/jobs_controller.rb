class JobsController < ApplicationController
  def index
    # @jobs = Job.search(params[:search]).order('created_at DESC').page(params[:page])
      @job_ids = get_jobs_rsolr(params[:search] || '*')
      @jobs = Job.where(id: @job_ids).order('created_at DESC').page(params[:page])
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
    @cities = City.all.select{ |city| city.jobs.any? }.take(8)
  end

  def get_jobs_rsolr(title = '*')
    solr = RSolr.connect url: 'http://localhost:8983/solr/gettingstarted/'
    search_params = { q: "search_text:*#{title.downcase}*", rows: 5_000 }
    response_solr = solr.get 'select', params: search_params
    if response_solr['response']['docs'].any?
      response_solr['response']['docs'].collect do |row|
        row['job_id']
      end
    end
  end
end
