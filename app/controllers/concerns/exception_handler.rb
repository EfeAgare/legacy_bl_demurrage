# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from AuthenticationError, with: :unauthorized_access
    rescue_from MissingToken, with: :four_four_two
    rescue_from InvalidToken, with: :four_four_two
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(data: { errors: [ e.message ] }, status: :not_found)
    end
  end

  private

  def four_four_two(error)
    json_response(data: { errors: [ error.message ] }, status: :unprocessable_entity)
  end

  def unauthorized_access(error)
    json_response(data: { errors: [ error.message ] }, status: :unauthorized)
  end
end
