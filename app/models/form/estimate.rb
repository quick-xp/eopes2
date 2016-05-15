# == Schema Information
#
# Table name: estimates
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  sell_price          :decimal(20, 4)
#  sell_count          :integer
#  product_type_id     :integer
#  total_cost          :decimal(20, 4)
#  sell_total_price    :decimal(20, 4)
#  material_total_cost :decimal(20, 4)
#  profit              :decimal(20, 4)
#  total_volume        :decimal(20, 4)
#  production_time     :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Form::Estimate < Estimate
  REGISTRABLE_ATTRIBUTES = %i(type_id sell_price sell_count product_type_id
                              total_cost material_total_cost profit total_volume sell_total_price production_time)

  has_many :estimate_materials, class_name: 'Form::EstimateMaterial', inverse_of: :estimate, :dependent => :destroy
  has_one :estimate_blueprint, class_name: 'Form::EstimateBlueprint', inverse_of: :estimate, :dependent => :destroy
  has_one :estimate_job_cost, class_name: 'Form::EstimateJobCost',inverse_of: :estimate, :dependent => :destroy

  accepts_nested_attributes_for :estimate_materials, allow_destroy: true
  accepts_nested_attributes_for :estimate_blueprint, allow_destroy: true
  accepts_nested_attributes_for :estimate_job_cost, allow_destroy: true

  after_initialize { estimate_materials.build unless self.persisted? || estimate_materials.present? }
  after_initialize { self.build_estimate_job_cost unless self.persisted? || estimate_job_cost.present? }
  after_initialize { self.build_estimate_blueprint unless self.persisted? || estimate_blueprint.present? }

  attr_accessor :product_region_sell_price_average
  attr_accessor :product_universe_sell_price_average

  # 見積もりの初期設定を行う その際に下記を行う
  # 1.Blueprintの初期設定
  # 2.Blueprintに対応するMaterialのJita priceの更新
  # 3.Blueprintに対応するMaterialの初期設定
  # 4.JobCostの初期設定
  def do_estimate_initialize(type_id, runs, me, te, region_id, solar_system_id)
    # blueprint init
    self.estimate_blueprint.initialize_blueprint(type_id)

    # blueprint情報指定なしの場合
    runs = self.estimate_blueprint.runs if runs == nil
    me = self.estimate_blueprint.me if me == nil
    te = self.estimate_blueprint.te if te == nil
    # jobcost init
    self.estimate_job_cost.initialize_job_cost(type_id,
                                               runs.to_i,
                                               region_id,
                                               solar_system_id)
    self.estimate_job_cost.calc_job_cost!

    # material init
    self.estimate_materials = Form::EstimateMaterial.get_material_list(type_id,
                                                                 me.to_i,
                                                                 te.to_i,
                                                                 runs.to_i)
  end

end
