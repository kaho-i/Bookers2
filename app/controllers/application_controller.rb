class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def dashboard
    @user = User.find_by(id: params[:id])
    if user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    elsif user.id != current_user.id
      redirect_to user_path(current_user)
    end
    @book = Book.new
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end