class CitiesJob < ApplicationRecord
  belongs_to :job, foreign_key: 'job_id'
  belongs_to :city, foreign_key: 'city_id'
  validates :job_id, presence: true
  validates :city_id, presence: true
end
