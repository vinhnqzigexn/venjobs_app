class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def record_not_found
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404",
                           layout: false,
                           status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
