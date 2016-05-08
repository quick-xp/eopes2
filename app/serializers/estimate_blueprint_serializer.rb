class EstimateBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :type_id, :me, :te, :runs, :estimate_id, :created_at, :updated_at, :product

  def product
    object.blueprint_product
  end
end
