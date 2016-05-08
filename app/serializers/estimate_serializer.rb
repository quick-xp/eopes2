class EstimateSerializer < ActiveModel::Serializer
  attributes(*Estimate.attribute_names.map(&:to_sym))

  has_one :estimate_blueprint
  has_one :estimate_job_cost
  has_many :estimate_materials
end
