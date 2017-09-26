require 'rails_helper'

describe Api::V1::UserBooksController do
  describe '#create' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:params) { { user_id: user.id, book_id: book.id } }

    it 'creates a UserBook' do
      expect { post :create, params: params }
        .to change { UserBook.count }.by(1)
    end

    it 'creates unread UserBook' do
      post :create, params: params
      user_book = user_book_from_json(response.body)

      expect(user_book.read).to eq(false)
    end

    it 'associates UserBook to User' do
      post :create, params: params
      user_book = user_book_from_json(response.body)

      expect(user_book.user).to eq(user)
    end

    it 'associates UserBook to Book' do
      post :create, params: params
      user_book = user_book_from_json(response.body)

      expect(user_book.book).to eq(book)
    end

    it 'returns 404 if cannot find user' do
      post :create, params: { user_id: user.id + 1, book_id: book.id }

      expect(response.status).to eq(404)
    end

    it 'returns 404 it cannot find book' do
      post :create, params: { user_id: user.id, book_id: book.id + 1 }

      expect(response.status).to eq(404)
    end

    it 'returns 400 if no book_id' do
      post :create, params: { user_id: user.id }

      expect(response.status).to eq(400)
    end
  end
end

def user_book_from_json(response_body)
  UserBook.find(JSON.parse(response_body)['id'])
end
