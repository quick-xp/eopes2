# == Schema Information
#
# Table name: estimate_materials
#
#  id                     :integer          not null, primary key
#  type_id                :integer
#  require_count          :integer
#  base_quantity          :integer
#  price                  :decimal(20, 4)
#  adjusted_price         :decimal(20, 4)
#  total_price            :decimal(20, 4)
#  jita_total_price       :decimal(20, 4)
#  jita_average_price     :decimal(20, 4)
#  universe_total_price   :decimal(20, 4)
#  universe_average_price :decimal(20, 4)
#  volume                 :decimal(20, 4)
#  total_volume           :decimal(20, 4)
#  estimate_id            :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Form::EstimateMaterial < EstimateMaterial
  REGISTRABLE_ATTRIBUTES = %i(id type_id require_count base_quantity price adjusted_price
                              total_price jita_total_price jita_average_price universe_total_price
                              universe_average_price volume total_volume _destroy)

  belongs_to :estimate, class_name: 'Form::Estimate'

  def self.get_material_list(blueprint_type_id, blueprint_me, blueprint_te, blueprint_runs)
    material_list = Array.new
    # 材料一覧取得
    materials = IndustryActivityMaterial.materials_for_production_job(blueprint_type_id)
    # Jita Market データ取得
    self.refresh_jita_market(materials)

    materials.each do |m|
      r = Form::EstimateMaterial.new
      r.type_id = m.materialTypeID
      r.base_quantity = m.quantity
      r.require_count = EstimateMaterial.require_material(blueprint_runs, m.quantity, blueprint_me, false)
      r.adjusted_price = MarketPrice.get_adjusted_price(r.type_id)
      r.jita_average_price = EstimateMaterial.jita_lower_price(r.type_id)
      r.jita_total_price = r.jita_average_price * r.require_count
      r.universe_average_price = MarketPrice.get_universe_average_price(r.type_id)
      r.universe_total_price = r.universe_average_price * r.require_count
      r.volume = InvType.type_volume(r.type_id)
      r.total_volume = r.volume * r.require_count
      r.price = r.jita_average_price.round(2)
      r.total_price = r.require_count * r.price
      material_list << r
    end
    material_list
  end

end
