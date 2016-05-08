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

  # 見積もりの初期化
  def new
    @estimate_form = Form::Estimate.new
    @estimate_form.do_estimate_initialize(params[:type_id],
                                          params[:runs],
                                          params[:me],
                                          params[:te],
                                          params[:region_id],
                                          params[:solar_system_id])
    render json: @estimate_form
  end

  private

  def set_estimate
    @project = Estimate.find(params[:id])
  end

  def project_params
    params.fetch(:project, {})
  end

end
