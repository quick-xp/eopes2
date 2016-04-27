# == Schema Information
#
# Table name: market_details
#
#  id         :integer          not null, primary key
#  volume     :integer
#  buy        :boolean
#  price      :decimal(10, )
#  duration   :integer
#  station_id :integer
#  issued     :datetime
#  market_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class MarketDetail < ActiveRecord::Base
  belongs_to :market
end
