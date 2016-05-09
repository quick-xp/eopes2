class EstimateMaterialSerializer < ActiveModel::Serializer
  attributes(*EstimateMaterial.attribute_names.map(&:to_sym))
  has_one :material_inv_type

end
