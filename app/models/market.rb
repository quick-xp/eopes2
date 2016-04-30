# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  region_id  :integer
#  station_id :integer
#  volume     :integer
#  buy        :boolean
#  price      :decimal(10, )
#  duration   :integer
#  issued     :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Market < ActiveRecord::Base

  #get_market_data
  def self.get_market_data(region_id, type_id, order_type = 'sell')
    #Crest を用いてマーケットデータ取得
    client = CrestClient.new("")
    response = nil
    if order_type == 'sell'
     response = client.get_market_sell_order(region_id, type_id)
    else
     response = client.get_market_buy_order(region_id, type_id)
    end

    markets = []
    items = response.items
    items.each do |item|
      market = Market.new
      market.region_id = region_id
      market.type_id = type_id
      market.volume = item.volume
      market.buy = item.buy
      market.price = item.price
      market.duration = item.duration
      market.station_id = item.location.id
      market.issued = item.issued.to_datetime

      markets << market
    end
    markets
  end

  #Market Data Refresh(Parallel)
  #一定時間以上経過している場合は、Crestからデータを取得、データ入れ替えを行う
  def self.refresh_market_parallel(region_id, type_id_lists)
    refresh_target_lists = Array.new

    #Refresh 対象選定
    type_id_lists.each do |type_id|
      market = Market.where(:region_id => region_id, :type_id => type_id).first
      if market.nil? ||
          market.updated_at < Time.now - ENV['JITA_PRICE_REFRESH_TIME'].to_i.minutes
        refresh_target_lists << type_id
      end
    end
    #Refresh 対象のデータ取得
    threads = []
    refresh_target_lists.each_with_index do |type_id, index|
      threads << Thread.new do
        #Crest を用いてマーケットデータ取得
        sell_orders = Market.get_market_data(region_id, type_id)
        Market.destroy_all(region_id: region_id, type_id: type_id)
        Market.import sell_orders
      end
    end
    threads.each { |t| t.join }
  end

end

