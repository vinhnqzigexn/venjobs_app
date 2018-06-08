class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 },
                   uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :address, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  VALID_PHONE_REGEX = /\A^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/
  validates :phone, length: { maximum: 20 },
                    format: { with: VALID_PHONE_REGEX }
  validates :fax, length: { maximum: 20 }
  validates :number_of_employees, length: { maximum: 20 }
end
