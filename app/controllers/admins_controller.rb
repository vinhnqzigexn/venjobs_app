class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  def create
    @admin = Admin.find_by(admin_id: params[:admin][:admin_id])
    if @admin && @admin.authenticated?(params[:admin][:password])
      flash.now[:success] = 'Admin login success'
      redirect_to admin_applies_url
      #session delete
    else
      flash.now[:danger] = 'Invalid id or password'
      render :new
    end
  end

  def destroy
    # log_out if logged_in?
    # redirect_to root_url
    
  end


  # Return the current logged-in user (if any).
  def current_user
    # @current_user ||= User.find_by(id: session[:user_id])
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # if user && user.authenticated?(cookies[:remember_token])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end


    # Logs out the current user.
    def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    # Forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end

end
