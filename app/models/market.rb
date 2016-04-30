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

end

