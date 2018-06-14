module JobsHelper
  def number_of_jobs_in_city(city_id)
    jobs = Job.where(city_id: city_id)
    jobs.count
  end
end
