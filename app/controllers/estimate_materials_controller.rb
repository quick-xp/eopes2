class EstimateMaterialsController < ApplicationController
  include ActionController::Serialization
  before_action :set_estimate, only: [:show]

  def index
    @estimate_materials = EstimateMaterial.my_estimate(get_current_user_id).all
    render json: @estimate_materials
  end

  def show
    render json: @estimate_materials
  end

  def new
    @estimate_materials = EstimateMaterial.get_material_list(params[:type_id],
                                                             params[:me].to_i,
                                                             params[:te].to_i,
                                                             params[:runs].to_i
                                                            )
    render json: @estimate_materials
  end

  private

  def set_estimate
    @estimate_materials = EstimateMaterial
      .my_estimate(get_current_user_id)
      .find_estimates(params[:id])
      .all
  end

end
