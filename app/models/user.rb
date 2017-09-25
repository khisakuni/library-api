# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_books

  validates :username, uniqueness: true
end
