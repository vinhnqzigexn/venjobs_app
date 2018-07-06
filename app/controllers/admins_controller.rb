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
    start_date =
      if params[:start_date]
        Time.zone.local( params[:start_date][:year],
                                  params[:start_date][:month],
                                  params[:start_date][:day])
      else 
        1.year.ago
      end

    end_date =
      if params[:end_date]
        Time.zone.local(params[:end_date][:year],
                                params[:end_date][:month],
                                params[:end_date][:day])
      else
        Time.now
      end

    job_ids = Entry.all.map(&:job_id)
    @jobs = Job.all
    @cities = City.all
    @industries = Industry.all
    # binding.pry
    @entries  = Entry.search( email: params[:email],
                              city_id: params[:city_id],
                              industry_id: params[:industry_id],
                              start_date: start_date,
                              end_date: end_date ).page(params[:page])
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
