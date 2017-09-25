# frozen_string_literal: true

class Api::V1::BooksController < ApplicationController
  def create
    book = Book.create(create_params)
    return render json: book, status: 201 if book.errors.empty?
    render json: { errors: book.errors.full_messages }, status: 400
  end

  private

  def create_params
    params.permit(:author, :title)
  end
end
