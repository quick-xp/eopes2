class EstimateJobCostsController < ApplicationController
  include ActionController::Serialization
  before_action :set_estimate, only: [:show]

  def index
    @estimate_job_costs = EstimateJobCost.my_estimate(get_current_user_id).all
    render json: @estimate_job_costs
  end

  def show
    render json: @estimate_job_cost
  end

  def new
    @estimate_job_cost = EstimateJobCost.new
    @estimate_job_cost.initialize_job_cost(params[:type_id],
                                           params[:runs].to_i,
                                           params[:region_id],
                                           params[:solar_system_id])
    @estimate_job_cost.calc_job_cost!
    render json: @estimate_job_cost
  end

  private

  def set_estimate
    @estimate_blueprint = EstimateJobCost
      .my_estimate(get_current_user_id)
      .find_estimate(params[:id])
  end

end
