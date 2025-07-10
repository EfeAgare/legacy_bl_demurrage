# frozen_string_literal: true

module Response
  extend ActiveSupport::Concern

  def json_response(data:, status: :ok)
    return render json: data, status: status unless data.respond_to? :deep_transform_keys!

    data.deep_transform_keys! { |key| key.to_s.camelize(:lower) }

    render json: data, status: status
  end
end
