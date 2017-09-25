require 'rails_helper'

describe Api::V1::BooksController do
  describe '#create' do
    let(:params) { { author: 'Uncle Bob', title: 'Clean Code' } }

    it 'creates new book' do
      expect { post :create, params: params }
        .to change { Book.count }.by(1)
    end

    it 'creates new book with author' do
      post :create, params: params
      book = Book.find(JSON.parse(response.body)['id'])

      expect(book.author).to eq(params[:author])
    end

    it 'creates new book with title' do
      post :create, params: params
      book = Book.find(JSON.parse(response.body)['id'])

      expect(book.title).to eq(params[:title])
    end

    it 'returns json' do
      post :create, params: params
      book = Book.find(JSON.parse(response.body)['id'])

      expect(response.body).to eq(book.to_json)
    end

    context 'if no author' do
      let(:params) { { author: 'Uncle Bob' } }

      it 'returns error' do
        post :create, params: params

        expect(response.status).to eq(400)
      end

      it 'does not create Book' do
        expect { post :create, params: params }
          .not_to(change { Book.count })
      end
    end

    context 'if no title' do
      let(:params) { { title: 'Clean Code' } }

      it 'returns error' do
        post :create, params: params

        expect(response.status).to eq(400)
      end

      it 'does not create Book' do
        expect { post :create, params: params }
          .not_to(change { Book.count })
      end
    end

    context 'if no author and no title' do
      it 'returns error' do
        post :create

        expect(response.status).to eq(400)
      end

      it 'does not create Book' do
        expect { post :create }
          .not_to(change { Book.count })
      end
    end
  end
end
