class ApplicationController < ActionController::Base
  def index
    render html: "Yep, It's working ..."
  end
end
