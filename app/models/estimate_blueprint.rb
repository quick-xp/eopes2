# == Schema Information
#
# Table name: estimate_blueprints
#
#  id          :integer          not null, primary key
#  type_id     :integer
#  me          :integer
#  te          :integer
#  runs        :integer
#  estimate_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class EstimateBlueprint < ActiveRecord::Base
  belongs_to :estimate

  scope :my_estimate, -> (user_id) do
    joins(:estimate).merge(Estimate.my_estimate(user_id))
  end

  scope :find_estimate, -> (id) do
    joins(:estimate).merge(Estimate.find(id: id))
  end

  def initialize_blueprint(type_id)
    self.type_id = type_id
    #blueprint初期のRun,me,te設定
    self.runs = 1
    self.me = 10
    self.te = 20
  end

  def blueprint_product
    IndustryActivityProduct.product_for_production_job(self.type_id)
  end
end
