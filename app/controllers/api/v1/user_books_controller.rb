# frozen_string_literal: true

class Api::V1::UserBooksController < ApplicationController
  def create
    return error_response('book_id must be present') unless valid_req?
    user_book = UserBook.create(create_params)
    return render json: user_book, status: 201 if user_book.errors.empty?
    error_response(user_book.errors.full_messages)
  end

  private

  def valid_req?
    params[:book_id].present?
  end

  def error_response(errors)
    render json: { errors: errors }, status: 400
  end

  def create_params
    { user: user, book: book }
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def book
    @book ||= Book.find(params[:book_id])
  end
end
