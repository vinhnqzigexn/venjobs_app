# frozen_string_literal: true

class City < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  validates :city_type, length: { maximum: 50 }
  validates :slug, length: { maximum: 50 }
  validates :name_with_type, length: { maximum: 50 }
  validates :path, length: { maximum: 50 }
end
