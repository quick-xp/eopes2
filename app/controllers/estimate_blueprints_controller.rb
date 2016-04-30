class EstimateBlueprintsController < ApplicationController
  include ActionController::Serialization
  before_action :set_estimate, only: [:show]

  def index
    @estimate = EstimateBlueprint.my_estimate(get_current_user_id).all
    render json: @estimate.estimate_blueprint
  end

  def show
    render json: @estimate_blueprint
  end

  def new
    @estimate_blueprint = EstimateBlueprint.initialize_blueprint(params[:type_id])
    render json: @estimate_blueprint
  end

  private

  def set_estimate
    @estimate_blueprint = EstimateBlueprint
      .my_estimate(get_current_user_id)
      .find(params[:id])
  end

end
