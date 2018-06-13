class Industry < ApplicationRecord
  has_many  :jobs, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 },
                   uniqueness: { case_sensitive: false }
end
