# == Schema Information
#
# Table name: industryActivity
#
#  typeID     :integer          not null, primary key
#  activityID :integer          not null
#  time       :integer
#

class IndustryActivity < ActiveRecord::Base
  self.table_name = 'industryActivity'
  establish_connection(:EveMasterDB)
  self.primary_key = :typeID

  def self.get_industry
    IndustryActivity.joins("inner join invTypes on industryActivity.typeID = invTypes.typeID")
                    .where(activityID: 1)
                    .where("invTypes.typeName NOT LIKE '%YC117%'")
                    .select("invTypes.typeID,invTypes.typeName")
                    .order("invTypes.typeName asc")
  end

end
