class CrestClient
  CREST_API_BASE_URL = 'https://crest-tq.eveonline.com'.freeze
  PUBLIC_CREST_API_BASE = 'https://public-crest.eveonline.com'.freeze

  def initialize(token)
    @token = token
  end

  def get_market_sell_order(region_id, type_id)
    path = CREST_API_BASE_URL + market_sell_order_url(region_id, type_id)
    Rails.logger.info("CrestClient Access to #{path}")

    MarketOrderResponse.parse(get_request_to(path))
  end


  private

  def build_api_connection
    Faraday.new(url: CREST_API_BASE_URL) do |builder|
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end
  end

  def get_request_to(path)
    conn = build_api_connection
    conn.get do |req|
      req.url path
    end
  end

  def market_sell_order_url(region_id, type_id)
    '/market/' + region_id.to_s + '/orders/sell/?type=https://public-crest.eveonline.com/types/' + type_id.to_s + '/'
  end

  def market_buy_order_url(region_id, type_id)
    '/market/' + region_id.to_s + '/orders/buy/?type=https://public-crest.eveonline.com/types/' + type_id.to_s + '/'
  end

end
