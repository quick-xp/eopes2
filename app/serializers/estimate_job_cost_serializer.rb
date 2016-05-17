class EstimateJobCostSerializer < ActiveModel::Serializer
  attributes(*EstimateJobCost.attribute_names.map(&:to_sym))
  attributes :region,:solar_system

  def region
    if object.region_id.present?
      MapRegion.where(regionID: object.region_id).first
    end
  end

  def solar_system
    if object.solar_system_id.present?
      MapSolarSystem.where(solarSystemID: object.solar_system_id).first
    end
  end

end
