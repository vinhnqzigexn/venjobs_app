class Admin < ApplicationRecord
  validates :admin_id,  presence: true
  validates :password_digest,  presence: true
  has_secure_password
end
