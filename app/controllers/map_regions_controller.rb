class MapRegionsController < ApplicationController
  def index
    @regions = MapRegion.all.order(:regionName)
    render json: @regions
  end
end
