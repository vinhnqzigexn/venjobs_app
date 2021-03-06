# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :favorite_jobs, dependent: :destroy

  has_many :entries,  foreign_key: 'user_id',
                      dependent: :destroy
  has_many :jobs, through: :entries

  # validates :name, presence: true, length: { maximum: 255 }

  # validates :prefix, presence: true

  # VALID_PHONE_REGEX = /\A^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/
  # validates :phone, length: { maximum: 50 },
  #                   format: { with: VALID_PHONE_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true, length: { minimum: 8 }

  # Sends apply email.
  def send_job_apply_email(job)
    UserMailer.job_apply(self, job).deliver_now
  end

end
