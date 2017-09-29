# frozen_string_literal: true

class Api::V1::UserBooksController < ApplicationController
  def index
    data = user_books.page(page).per(per_page)
    res = {
      data: data.map { |d| UserBookSerializer.new(d).as_json },
      page: page,
      per_page: per_page,
      total_pages: data.total_pages,
      total_count: data.total_count
    }

    render json: res
  end

  def create
    return error_response('book_id must be present') unless valid_req?
    user_book = UserBook.create(create_params)
    return render json: user_book, status: 201 if user_book.errors.empty?
    error_response(user_book.errors.full_messages)
  end

  def update
    if user_book.update(update_params)
      render json: user_book, status: 200
    else
      error_response(user_book.errors.full_messages)
    end
  end

  def destroy
    user_book.destroy
    head :ok
  end

  private

  def valid_req?
    params[:book_id].present?
  end

  def error_response(errors)
    render json: { errors: errors }, status: 400
  end

  def user_book
    @user_book ||= user.user_books.find(params[:id])
  end

  def update_params
    params.permit(:read)
  end

  def create_params
    { user: user, book: book }
  end

  def user_books
    @user_books ||= begin
      UserBooksFilter.new(UserBook, params).perform
    end
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def book
    @book ||= Book.find(params[:book_id])
  end

  def page
    params.fetch(:page, 1)
  end

  def per_page
    params.fetch(:per_page, 10)
  end
end
