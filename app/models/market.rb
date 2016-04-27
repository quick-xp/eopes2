# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  region_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Market < ActiveRecord::Base
  has_many :market_details, :dependent => :destroy

  end

