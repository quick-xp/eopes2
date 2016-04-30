class EstimatesController < ApplicationController
  include ActionController::Serialization
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]

  def index
    @estimates = Estimate.where(user_id: get_current_user_id)
    render json: @estimates
  end

  def show
    render json: @estimate
  end

  private

  def set_estimate
    @project = Estimate.find(params[:id])
  end

  def project_params
    params.fetch(:project, {})
  end

end
