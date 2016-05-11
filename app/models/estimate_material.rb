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

class EstimateMaterial < ActiveRecord::Base
  belongs_to :estimate
  belongs_to :material_inv_type, class_name: 'InvType', foreign_key: "type_id"

  scope :my_estimate, -> (user_id) do
    joins(:estimate).merge(Estimate.my_estimate(user_id))
  end

  scope :find_estimates, -> (id) do
    joins(:estimate).merge(Estimate.where(id: id))
  end

  #material require = max(runs,ceil(round(runs * baseQuantity * materialModifier,2))
  #materialModifire = ME * FacilityModifier
  #FacilityModifire = NPC_STATION:1.0,POS:0.98
  def self.require_material(runs, base_quantity, me, pos_flag = false)
    facility_modifier = 1.0
    if pos_flag
      facility_modifier = 0.98
    end
    result = (runs * base_quantity * facility_modifier * (1.0 - me * 0.01)).ceil
    #計算の結果Runsのほうが大きい場合はRunsを必要量とする
    if result < runs
      runs
    else
      result
    end
  end

  def self.get_material_list(blueprint_type_id, blueprint_me, blueprint_te, blueprint_runs)
    material_list = Array.new
    # 材料一覧取得
    materials = IndustryActivityMaterial.materials_for_production_job(blueprint_type_id)
    # Jita Market データ取得
    self.refresh_jita_market(materials)

    materials.each do |m|
      r = EstimateMaterial.new
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

  def self.jita_lower_price(type_id)
    m = Market.where(
      region_id: "10000002",
      station_id: "60003760",
      type_id: type_id)
      .order(:price)
      .first
    if m == nil
      0.0
    else
      m.price
    end
  end

  def self.refresh_jita_market(materials)
    type_id_lists = []
    materials.each do |m|
      type_id_lists << m.materialTypeID
    end
    Market.refresh_market_parallel("10000002", type_id_lists)
  end
end
