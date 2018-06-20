class IndustriesJob < ApplicationRecord
  belongs_to :job, foreign_key: 'job_id'
  belongs_to :industry, foreign_key: 'industry_id'
  validates :job_id, presence: true
  validates :industry_id, presence: true
end
