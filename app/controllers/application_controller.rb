# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  private

  def handle_record_not_found
    render json: { error: 'Not found' }, status: 404
  end
end
