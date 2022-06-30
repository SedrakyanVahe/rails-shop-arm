class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :set_logged_in_user, if: :user_signed_in?
  rescue_from ActiveRecord::RecordNotFound, with: :notfound

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(
      :role,
      :first_name,
      :last_name,
      :email,
      :password
      )
    }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(
      :role, 
      :first_name, 
      :last_name, 
      :email, 
      :gender, 
      :birth_date, 
      :country, 
      :phone, 
      :avatar, 
      :password, 
      :current_password
      )
    }

  end

  private

  def set_logged_in_user
    ApplicationRecord.set_logged_in_user(@current_user)
  end

  def notfound
    render file: 'public/404.html', status: :not_found, layout: false
  end

end