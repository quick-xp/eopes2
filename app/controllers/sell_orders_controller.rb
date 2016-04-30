class SellOrdersController < ApplicationController
  include ActionController::Serialization

  def get_jita_lower_price
    @estimate_material = EstimateMaterial.jita_lower_price(params[:type_id])
    render json: @estimate_material
  end
end
