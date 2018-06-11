# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :company, foreign_key: 'company_id'
  belongs_to :city, foreign_key: 'city_id'
  belongs_to :industry, foreign_key: 'industry_id'

  has_many  :entries, dependent: :destroy
  has_many  :favorite_jobs, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }

  validates :position, presence: true, length: { maximum: 255 }
  VALID_NUMBER_REGEX = /\A((\d{0,12}(\.\d{0,2})?)|(\.\d{0,2}))\z/
  validates :salary, presence: true,
                     format: { with: VALID_NUMBER_REGEX },
                     numericality: {
                       greater_than: 0.00,
                       less_than: 999_999_999_999.99
                     }
  validates :expiry_date, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :update_date, presence: true
  validates :published, presence: true, inclusion: { in: [true, false] }
  validates :welfare, presence: true, length: { maximum: 1000 }
  validates :condition, presence: true, length: { maximum: 1000 }
end
