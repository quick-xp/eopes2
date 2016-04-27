# == Schema Information
#
# Table name: industryActivityMaterials
#
#  typeID         :integer
#  activityID     :integer
#  materialTypeID :integer
#  quantity       :integer
#

class IndustryActivityMaterial < ActiveRecord::Base
  self.table_name = 'industryActivityMaterials'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID,:activityID,:materialTypeID

  belongs_to :inv_type, class_name: 'InvType', foreign_key: "typeID"
  belongs_to :material_inv_type, class_name: 'InvType', foreign_key: "typeID"

  def self.materials_for_production_job(blueprint_type_id)
    activity_materials = IndustryActivityMaterial
      .where(:typeID => blueprint_type_id, :activityID => 1)
    activity_materials
  end

  def base_quantity
    self.quantity
  end

  def adjusted_price
    price = self.material_inv_type.market_price.try(:adjusted_price)
    price = 0 if price.nil?
    price
  end
end
