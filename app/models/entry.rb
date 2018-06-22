class Entry < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :job, foreign_key: 'job_id'
  validates :entry_name, presence: true
  validates :entry_email, presence: true
end
