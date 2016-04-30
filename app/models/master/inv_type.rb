# == Schema Information
#
# Table name: invTypes
#
#  typeID        :integer          not null, primary key
#  groupID       :integer
#  typeName      :string(100)
#  description   :text(4294967295)
#  mass          :float(53)
#  volume        :float(53)
#  capacity      :float(53)
#  portionSize   :integer
#  raceID        :integer
#  basePrice     :decimal(19, 4)
#  published     :boolean
#  marketGroupID :integer
#  iconID        :integer
#  soundID       :integer
#  graphicID     :integer
#

class InvType < ActiveRecord::Base
  self.table_name = 'invTypes'
  self.primary_key = 'typeID'
  establish_connection(:EveMasterDB)

  def self.type_name(typeID)
    InvType.find(typeID).try(:typeName)
  end

  def self.description(typeID)
    InvType.find(typeID).try(:description)
  end

  def self.type_volume(typeID)
    InvType.find(typeID).try(:volume)
  end

  def market_price
    MarketPrice.where(type_id: self.typeID).first
  end

  def type_name_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 8]).first.try(:text)
  end

  def description_jp
    TrnTranslation.where(['keyID = ? and languageID = ? and tcID = ?', self.typeID, 'JA', 33]).first.try(:text)
  end
end
