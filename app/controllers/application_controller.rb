class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def authenticate_user!
    if user_signed_in? || request.original_fullpath.include?('/users/')
      super
    else
      redirect_to '/splash'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :email, :password, :current_password)
    end
  end
end
