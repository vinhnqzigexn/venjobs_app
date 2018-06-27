# frozen_string_literal: true

namespace :update do
  desc 'update solr index from database'
  task solr: :environment do
    solr = RSolr.connect url: 'http://localhost:8983/solr/gettingstarted/'

    jobs = Job.all

    if jobs.any?
      jobs.each_with_index do |job, id|
        # break if id == 10
        # check is job_id is exist and not update job to solr
        response_solr = solr.get 'select', params: { q: "job_id: #{job['id']}" }
        next if response_solr['response']['docs'].any?

        # hash of job attribute array: city_name, ...
        h = {}

        # h['city_id']       = job.cities.collect { |city| city['id'].to_s }
        h['city_name']     = job.cities.collect { |city| city['name'].downcase }
        h['city_slug']     = job.cities.collect { |city| city['slug'] }
        # h['industry_id']   = job.industries.collect { |ind| ind['id'].to_s }
        h['industry_name'] = job.industries.collect { |ind| ind['name'].downcase }
        h['industry_slug'] = job.industries.collect { |ind| ind['slug'] }
        h['company_name']  = job.company.name.downcase

        doc = {
          job_id:             job.id,
          job_title:          job.title.downcase,
          # job_city_id:        h['city_id'],
          job_city_name:      h['city_name'],
          job_city_slug:      h['city_slug'],
          # job_industry_id:    h['industry_id'],
          job_industry_name:  h['industry_name'],
          job_industry_slug:  h['industry_slug'],
          job_company_name:   h['company_name']
        }
        solr.add [doc]
      end
      solr.commit

    end
    # solr.delete_by_query '*:*'
    # solr.commit
  end
end
