# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update]
  before_action :entry_params, only: [:create]

  # GET /entries/1
  # GET /entries/1.json
  def show; end

  # GET /entries/new
  def new
    @entry = if user_signed_in?
               Entry.new(entry_name:    current_user.name,
                         entry_email:   current_user.email,
                         entry_phone:   current_user.phone,
                         entry_address: current_user.address)
             else
               Entry.new
             end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
      render :new and return unless @entry.valid?

      @job = Job.find(params[:job_id])

      @user = User.find_by(email: params[:entry][:entry_email])
      unless @user
        random_password = Devise.friendly_token
        @user = User.new(name:   params[:entry][:entry_name],
                        email:   params[:entry][:entry_email],
                        phone:   params[:entry][:entry_phone],
                        address: params[:entry][:entry_address],
                        password:              random_password,
                        password_confirmation: random_password)
        render :new and return unless @user.valid?
        @user.skip_confirmation!
        @user.save
      end

      @entry.user_id = @user.id
      @entry.job_id = @job.id

      if @user.jobs.find_by(id: @job.id)
        redirect_to job_url(@job), flash: { secondary: 'You has been entry this job.' }
      else
        if @entry.save
          UserMailer.job_apply(@user, @job).deliver_now
          redirect_to @entry, flash: { secondary: 'Thank you for apply. Please check your email.' }
        else
          render :new
        end
      end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:entry_name, :entry_email, :entry_phone, :entry_address)
  end
end
