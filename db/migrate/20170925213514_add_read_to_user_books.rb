class AddReadToUserBooks < ActiveRecord::Migration[5.1]
  def change
    add_column(:user_books, :read, :bool, default: false)
  end
end
