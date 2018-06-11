# frozen_string_literal: true

class City < ApplicationRecord
  has_many  :jobs, dependent: :destroy
  
  validates :name,  presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :city_type, length: { maximum: 255 }
  validates :slug, length: { maximum: 255 }
  validates :name_with_type, length: { maximum: 255 }
  validates :path, length: { maximum: 255 }
  
end
