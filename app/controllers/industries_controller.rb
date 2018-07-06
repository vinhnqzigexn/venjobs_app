class IndustriesController < ApplicationController
  def index
    @industries = Industry.all.select { |industry| industry.jobs.any? }
  end
end
