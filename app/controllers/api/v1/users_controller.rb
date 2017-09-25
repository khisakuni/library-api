# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def create
    return error_response('username must be present') unless valid_req?
    user = User.create(create_params)
    return render json: user, status: 201 if user.errors.empty?
    render json: { errors: user.errors.full_messages }, status: 400
  end

  private

  def error_response(errors)
    render json: { errors: errors }, status: 400
  end

  def valid_req?
    params[:username].present?
  end

  def create_params
    params.permit(:username)
  end
end
