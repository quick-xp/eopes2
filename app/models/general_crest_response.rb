class GeneralCrestResponse
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor *%i(
    is_success items total_count
  )

  def self.parse(response)
    new.tap do |r|
      body = JSON.parse(response.body)

      r.is_success = response.success?
      r.items = if body['items'].present?
                  body['items'].map { |v| HashObject.new(v) }
                else
                  []
                end
      r.total_count = body['totalCountStr'].to_i
    end
  end
end
