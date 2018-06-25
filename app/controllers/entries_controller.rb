# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show; end

  # GET /entries/new
  def new
    if params[:entry_name].blank? && params[:entry_email]
      @entry = Entry.new
    else
      @entry = Entry.new(entry_name: params[:entry_name], entry_email: params[:entry_email])
    end
  end

  # GET /entries/1/edit
  def edit; end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    @job = Job.find(params[:job_id])

    @user = User.find_by(email: params[:entry][:entry_email]) ||
            User.create(name: params[:entry][:entry_name],
                        email: params[:entry][:entry_email],
                        password:              'password',
                        password_confirmation: 'password')

    @entry.user_id = @user.id
    @entry.job_id = @job.id

    if @user.jobs.include?(@job)
      # redirect_to job_url(@job), notice: 'You has been entry this job.'
      redirect_to job_url(@job), flash: { secondary: 'You has been entry this job.' }
    elsif
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

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:entry_name, :entry_email)
  end
end
