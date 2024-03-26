class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  include ActionView::Helpers::TextHelper
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.update(user_params)
      flash[:notice] = '%s successfully.' % 'You have updated user'
      redirect_to @user
    else
      error_count = @user.errors.count
      flash[:alert] = '%s prohibited this %s from being saved:' % [ pluralize(error_count, "error"), 'obj' ]
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :password, :introduction)
  end
  
  def is_matching_login_user
    user = User.find_by(id: params[:id])
    if user.nil?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    elsif user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

end
