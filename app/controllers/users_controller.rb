class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
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
      flash[:notice] = '%s prohibited this %s from being saved:' % [ @user.errors.count == 1 ? "1 error" : "#{@user.errors.count} errors", 'obj' ]
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :password, :introduction)
  end

end
