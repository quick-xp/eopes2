# == Schema Information
#
# Table name: estimate_job_costs
#
#  id                :integer          not null, primary key
#  region_id         :integer
#  solar_system_id   :integer
#  system_cost_index :decimal(20, 16)
#  base_job_cost     :decimal(20, 4)
#  job_fee           :decimal(20, 4)
#  facility_cost     :decimal(20, 4)
#  total_job_cost    :decimal(20, 4)
#  estimate_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class EstimateJobCost < ActiveRecord::Base
  belongs_to :estimate
  attr_accessor :blueprint_type_id, :blueprint_runs

  scope :my_estimate, -> (user_id) do
    joins(:estimate).merge(Estimate.my_estimate(user_id))
  end

  def calc_job_cost!
    #SystemCostIndex設定
    self.system_cost_index =
      EstimateJobCost.calc_system_cost_index(self.region_id, self.solar_system_id)

    #BaseJobCost設定
    self.base_job_cost = calc_base_job_cost(self.blueprint_type_id, self.blueprint_runs)

    #JobFee設定
    self.job_fee = calc_job_fee(self.system_cost_index, self.base_job_cost)

    #FacilityCost設定
    self.facility_cost = calc_facility_cost(self.system_cost_index, self.base_job_cost)

    #TotalJobInstallCost設定
    self.total_job_cost = calc_total_job_cost(self.job_fee, self.facility_cost)
  end

  def initialize(blueprint_type_id, blueprint_runs, region_id = "", solar_system_id = "")
    super()
    self.blueprint_type_id = blueprint_type_id
    self.blueprint_runs = blueprint_runs
    self.region_id = region_id
    self.solar_system_id = solar_system_id
  end

  #region_id,solar_system_idどちらも指定されていない場合は全Cost_Indexの平均を
  #region_idのみ指定の場合は、Region内のCost_Indexの平均を
  #solar_system_idまで指定している場合はSolarSystemのCost_Indexを取得する
  def self.calc_system_cost_index(region_id, solar_system_id)
    if region_id.nil?
      region_id = ""
    end
    if solar_system_id.nil?
      solar_system_id = ""
    end

    result = 0.0
    if region_id == "" && solar_system_id == ""
      result = IndustrySystem.where(:activity_id => 1).average(:cost_index)
    elsif solar_system_id == ""
      solar_systems = MapSolarSystem.where(:regionID => region_id)
      costs_sum = 0.0
      solar_systems.each do |s|
        v1 = IndustrySystem.where(:solar_system_id => s.solarSystemID).first
        if v1 != nil
          costs_sum += v1.cost_index.to_f
        end
      end
      if solar_systems.present?
        result = costs_sum / solar_systems.count
      end
    else
      v1 = IndustrySystem.where(:solar_system_id => solar_system_id, :activity_id => 1).first
      if v1 != nil
        result = v1.cost_index.to_f
      end
    end
    result
  end

  #BaseJobCost計算
  #Σ( baseQuantity * adjustedPrice)
  def calc_base_job_cost(blueprint_type_id, blueprint_runs)
    base_job_cost = 0.0
    materials = IndustryActivityMaterial.materials_for_production_job(blueprint_type_id)
    materials.each do |material|
      base_job_cost += material.base_quantity * material.adjusted_price
    end
    base_job_cost * blueprint_runs
  end

  #JobFee計算
  #system_cost_index * baseJobCost
  def calc_job_fee(system_cost_index, base_job_cost)
    system_cost_index * base_job_cost
  end

  #FacilityCost計算
  #JobFee * taxRate / 100
  def calc_facility_cost(job_fee, tax_rate = 10)
    job_fee * tax_rate / 100
  end

  #TotalJobCost計算
  #JobFee + FacilityCost
  def calc_total_job_cost(job_fee, facility_cost)
    job_fee + facility_cost
  end

end
