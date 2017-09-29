class UserBookSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  belongs_to :book
end
