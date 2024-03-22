class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  
  def after_sign_in_path_for(resource)
    books_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def dashboard
    @user = current_user
    @book = Book.new
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
  
  private
  
  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'show'
      'users/show'
    elsif controller_name == 'books' && action_name == 'new'
      'books/new'
    else
      'application'
    end
  end
end
