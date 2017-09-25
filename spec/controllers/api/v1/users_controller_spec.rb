# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::UsersController do
  describe '#create' do
    let(:params) { { username: 'foobar' } }

    it 'creates new user' do
      expect { post :create, params: params }
        .to change { User.count }.by(1)
    end

    it 'has json response' do
      post :create, params: params
      expected = User.last.to_json

      expect(response.body).to eq(expected)
    end

    it 'creates new user with username' do
      post :create, params: params

      expect(User.last.username).to eq(params[:username])
    end

    it 'has error status if no username' do
      post :create

      expect(response.status).to eq(400)
    end

    it 'does not create user if no username' do
      expect { post :create }.not_to(change { User.count })
    end

    it 'has error status if username not unique' do
      create(:user, username: params[:username]) # create dup

      expect { post :create, params: params }.not_to(change { User.count })
    end
  end
end
