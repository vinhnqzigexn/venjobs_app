class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.job_apply.subject
  # 
  # def job_apply
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end
  def job_apply(user,job)
    @user = user
    @job = job
    mail to: user.email, subject: 'Thank you for apply with VeNJOB'
  end
end
