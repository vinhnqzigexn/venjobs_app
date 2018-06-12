class Job < ApplicationRecord
  belongs_to :company, foreign_key: 'company_id'
  belongs_to :city, foreign_key: 'city_id'
  belongs_to :industry, foreign_key: 'industry_id'
end
