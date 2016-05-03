class ManufactureAvailablesController < ApplicationController
  include ActionController::Serialization

  def index
    @availables = IndustryActivity.manufacture_availables(params[:searchWord]).limit(100)
    render json: @availables
  end
end
