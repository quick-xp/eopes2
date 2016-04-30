class EstimateBlueprintsController < ApplicationController
  include ActionController::Serialization
  before_action :set_estimate, only: [:show]

  def index
    @estimate_blueprints = EstimateBlueprint.my_estimate(get_current_user_id).all
    render json: @estimate_blueprints
  end

  def show
    render json: @estimate_blueprint
  end

  def new
    @estimate_blueprint = EstimateBlueprint.new
    @estimate_blueprint.initialize_blueprint(params[:type_id])
    render json: @estimate_blueprint
  end

  private

  def set_estimate
    @estimate_blueprint = EstimateBlueprint
      .my_estimate(get_current_user_id)
      .find_estimate(params[:id])
  end

end
