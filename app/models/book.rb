# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :user_books

  validates :title, presence: true
  validates :author, presence: true
end
