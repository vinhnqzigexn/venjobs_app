class Industry < ApplicationRecord
  has_many :industries_jobs,  foreign_key: 'industry_id',
                              dependent: :destroy
  has_many :jobs, through: :industries_jobs

  validates :name, presence: true, length: { maximum: 255 },
                   uniqueness: { case_sensitive: false }
end
