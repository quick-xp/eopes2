class EstimateBlueprintSerializer < ActiveModel::Serializer
  attributes :id, :type_id, :me, :te, :runs, :estimate_id, :created_at, :updated_at, :product, :manufacture_product_quantity

  def product
    object.blueprint_product
  end

  def manufacture_product_quantity
    object.manufacture_product_quantity
  end
end
