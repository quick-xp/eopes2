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
    estimate_blueprint = EstimateBlueprint.new
    estimate_blueprint.type_id = type_id
    #blueprint初期のRun,me,te設定
    estimate_blueprint.runs = 1
    estimate_blueprint.me = 10
    estimate_blueprint.te = 20
  end
end
