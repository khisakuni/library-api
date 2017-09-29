# frozen_string_literal: true

class UserBooksFilter
  attr_reader :params, :user_books

  def initialize(user_books, params)
    @user_books = user_books
    @params = sanitize(params)
  end

  def perform
    params.each { |k, _| filters[k].call }
    user_books.all
  end

  private

  def sanitize(params)
    params.extract!(*filters.keys)
  end

  def filters
    {
      read: ->() { by_read },
      author: ->() { by_author }
    }.with_indifferent_access
  end

  def by_read
    @user_books = user_books.where(read: params[:read])
  end

  def by_author
    @user_books = user_books
                  .joins(:book)
                  .where('books.author ILIKE ?', "%#{params[:author]}%")
  end
end
