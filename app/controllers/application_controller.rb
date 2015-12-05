class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception if Rails.env.production?

  rescue_from Timeout::Error do |e|
    render json: {error: 'Request timeout'}, status: 408
  end

end
