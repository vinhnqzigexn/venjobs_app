# frozen_string_literal: true

class City < ApplicationRecord
  has_many :cities_jobs,  foreign_key: 'city_id',
                          dependent: :destroy
  has_many :jobs, through: :cities_jobs

  validates :name,  presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :city_type, length: { maximum: 255 }
  validates :slug, length: { maximum: 255 }
  validates :name_with_type, length: { maximum: 255 }
  validates :path, length: { maximum: 255 }
end
