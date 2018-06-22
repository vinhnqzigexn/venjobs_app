# frozen_string_literal: true
class EntriesController < ApplicationController
  before_action :reg_params, only: [:create]
  before_action :apply_params, only: [:done]

  def new
    @job = Job.find(params[:job_id])
    # @entry = Entry.new
  end

  def edit
  end

  def create
    @job = Job.find(params[:job_id])

    if params[:entry][:entry_name].blank?
      flash.now[:danger] = "Name can't be empty."
      render action: 'new'
    elsif params[:entry][:entry_email].blank?
      flash.now[:danger] = "Email can't be empty."
      render action: 'new'
    else
      @user = User.new(name: params[:entry][:entry_name],
                       email: params[:entry][:entry_email],
                       password:              'password',
                       password_confirmation: 'password')
      if @user.valid?
        render 'confirm'
      else
        flash.now[:danger] = 'Email is taken or invalid'
        render 'edit'
        # render 'new', entry: { name: params[:entry][:name],
        #                          email: params[:entry][:email] }
      end
    end
  end

  def confirm
  end

  def done
    @user = User.find_by(email: params[:email].downcase) ||
            User.create(name: params[:name],
                        email: params[:email],
                        password:              'password',
                        password_confirmation: 'password')
    @job = Job.find(params[:job_id])
    @entry = Entry.create(job_id: @job.id, user_id: @user_id)
    @user.send_job_apply_email(@job)
    flash.now[:info] = 'Thanks you for apply job'
    redirect_to root_url
  end

  private

  def reg_params
    params.require(:entry).permit(:entry_name, :entry_email)
  end

  def apply_params
    params.permit(:entry_name, :entry_email, :job_id)
  end
end
