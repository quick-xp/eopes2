class MapSystemCostsController < ApplicationController
  def index
    @production_system_cost_index =
      EstimateJobCost.calc_system_cost_index(params[:region_id],params[:solar_system_id])

    render json: {production_system_cost_index: @production_system_cost_index}
  end
end
