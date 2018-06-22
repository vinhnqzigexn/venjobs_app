class Entry < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :job, foreign_key: 'job_id'
  validates :job_id, presence: true
  validates :user_id, presence: true
  validates :entry_name, presence: true

  # Sends password reset email.
  def send_apply_confirm_email
    UserMailer.password_reset(self).deliver_now
  end
end
