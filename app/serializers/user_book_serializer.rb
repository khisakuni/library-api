class UserBookSerializer < ActiveModel::Serializer
  attributes :id, :read
  belongs_to :user
  belongs_to :book
end
