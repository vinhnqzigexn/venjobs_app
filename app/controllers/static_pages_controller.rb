class StaticPagesController < ApplicationController
  def home
    @jobs = Job.all.order(updated_at: :desc).take(5)
    @cities = City.all.take(6)
  end
end
