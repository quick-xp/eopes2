class ManufactureAvailablesController < ApplicationController
  include ActionController::Serialization

  def index
    @availables = IndustryActivity.manufacture_availables
    render json: @availables
  end
end
