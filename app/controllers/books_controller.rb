class BooksController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = '%s successfully.' % 'You have created book'
      redirect_to book_path(@book)
    else
      error_count = @book.errors.count
      flash[:alert] = '%s prohibited this %s from being saved:' % [ pluralize(error_count, "error"), 'obj' ]
      @books = Book.all
      render :index
    end
  end

  def index
    @books =Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.update(book_params)
      flash[:notice] = '%s successfully.' % 'You have updated book'
      redirect_to user_path(@user.id)
    else
      error_count = @book.errors.count
      flash[:alert] = '%s prohibited this %s from being saved:' % [ pluralize(error_count, "error"), 'obj' ]
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end

end
