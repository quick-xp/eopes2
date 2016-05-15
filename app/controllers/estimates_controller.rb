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

  def create
   @estimate_form = Form::Estimate.new(estimate_params)
   if @estimate_form.save
     render json: {result: "success", estimate_form: @estimate_form}
   else
     render json: {result: "error", message: @estimate_form.errors.messages}
   end
  end

  private

  def set_estimate
    @project = Estimate.find(params[:id])
  end

  def estimate_params
    params
    .require(:estimate)
    .permit(
      Form::Estimate::REGISTRABLE_ATTRIBUTES +
      [estimate_blueprint_attributes: Form::EstimateBlueprint::REGISTRABLE_ATTRIBUTES] +
      [estimate_materials_attributes: Form::EstimateMaterial::REGISTRABLE_ATTRIBUTES] +
      [estimate_job_cost_attributes: Form::EstimateJobCost::REGISTRABLE_ATTRIBUTES]
    )
  end


end
