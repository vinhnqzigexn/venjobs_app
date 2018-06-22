# frozen_string_literal: true
class EntriesController < ApplicationController
  before_action :reg_params, only: [:create]
  before_action :apply_params, only: [:done]

  def new
    @job = Job.find(params[:job_id])
    @entry = Entry.new
  end


  def create
    @job = Job.find(params[:job_id])

    @user = User.find_by(email: params[:email].downcase) ||
            User.create(name: params[:entry][:entry_name],
                        email: params[:email],
                        password:              'password',
                        password_confirmation: 'password')
    @job = Job.find(params[:job_id])
    @entry = Entry.create(job_id: @job.id, user_id: @user_id)
    @user.send_job_apply_email(@job)
    flash.now[:info] = 'Thanks you for apply job'
    redirect_to root_url
  end

  def edit
  end

  private

  def reg_params
    params.require(:entry).permit(:entry_name, :entry_email)
  end

  def apply_params
    params.permit(:entry_name, :entry_email, :job_id)
  end
end
