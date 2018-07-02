class AdminsController < ApplicationController
  # before_action :logged_in_admin, only: :index

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.find_by(admin_id: params[:admin][:admin_id])
    if @admin && @admin.authenticate(params[:admin][:password])
      @current_admin = @admin
      flash[:success] = 'Admin login success'
      redirect_to admin_applies_url
    else
      flash.now[:danger] = 'Invalid id or password'
      render :new
    end
  end


  def index
    job_ids = Entry.all.map(&:job_id)
    # @jobs = Job.where(id: job_ids).page(params[:page])
    @jobs = Job.all
    @cities = City.all
    @industries = Industry.all
  end

  def destroy
    # log_out if logged_in?
    @current_admin = nil
    redirect_to root_url
  end

  private

  def search_filter
    params.permit(:search)
    s = params[:search].blank? ? '*' : params[:search]
    s.gsub(/[\/]/,'*')
  end

  # Confirms a logged-in user.
  def logged_in_admin
    # unless logged_in?
    #   flash[:danger] = 'Please log in.'
    #   redirect_to admin_login_url
    # end
    if @current_admin.nil?
      flash[:danger] = 'Please log in.'
      redirect_to admin_login_url
    end
  end

end
