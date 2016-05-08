# == Schema Information
#
# Table name: industryActivityProducts
#
#  typeID        :integer
#  activityID    :integer
#  productTypeID :integer
#  quantity      :integer
#

class IndustryActivityProduct < ActiveRecord::Base
  self.table_name = 'industryActivityProducts'
  establish_connection(:EveMasterDB)

  def self.product_for_production_job(blueprint_type_id)
    product = IndustryActivityProduct
      .where(typeID: blueprint_type_id, activityID: 1).first
    InvType.where(typeID: product.productTypeID).first
  end
end
