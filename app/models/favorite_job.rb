class FavoriteJob < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :job, foreign_key: 'job_id'
end
