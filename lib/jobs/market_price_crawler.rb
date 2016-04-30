# rails runner "Jobs::MarketPriceCrawler.new.run"
class Jobs::MarketPriceCrawler
  def run
    client = CrestClient.new("")
    crest_markets = client.get_market_price.items
    markets_result = []
    crest_markets.each do |m|
      r = MarketPrice.new
      r.type_id = m.type.id
      r.adjusted_price = m.adjustedPrice
      r.average_price = m.averagePrice
      markets_result << r
    end
    MarketPrice.delete_all
    MarketPrice.import markets_result
  end
end
