class MapSolarSystemsController < ApplicationController
  def index
    @solar_systems = MapSolarSystem.where(regionID: params[:region_id]).order(:solarSystemName)
    render json: @solar_systems
  end
end
