class EngagementRequestsController < ApplicationController
  include CodeGenerator

  def index
    @engagement_requests = EngagementRequest.all
    # check estimates to update
    @engagement_requests.each { |request| request.estimate }
  end

  def show
    @engagement_request = EngagementRequest.find(params[:id])
    # check estimate to update
    @engagement_request.estimate
  end

  def new
    @engagement_request = EngagementRequest.new
    # used for lookups
    @programs = Program.all
    @projects = Project.all
    @trains = Train.all
    @employees = Employee.all
  end

  def edit
    @engagement_request = EngagementRequest.find(params[:id])
    # used for lookups
    @programs = Program.all
    @projects = Project.all
    @trains = Train.all
    @employees = Employee.all
  end

  # In theory, the UI let's this always succeed (I suppose someone could post bad foreign keys)
  # We just make sure all the validations try to keep the status in Validation status.
  def create
    @engagement_request = EngagementRequest.new(engagement_request_params)
    @engagement_request.engagement_id = new_engagement_id
    @engagement_request.validate
    @engagement_request.save
    redirect_to @engagement_request
  end

  def update
    @engagement_request = EngagementRequest.find(params[:id])
    @engagement_request.update engagement_request_params
    @engagement_request.validate
    @engagement_request.save
    redirect_to @engagement_request
  end

  # once again, making up a format so we always have an identifier visible
  # Since the create form lets you create a completely blank item
  # Format: XX-NN-XXXX-XX
  def new_engagement_id
    [ random_chars(2), random_digits(2), random_chars(4), random_chars(2) ].join('-')
  end

  private

    def engagement_request_params
      params.require(:engagement_request).permit(
          :engagement_type, :project_name,
          :requester_id, :subject_expert_id, :sponsor_id,
          :vision, :goal, :description, :scope, :advice_required,
          :program_id, :train_id, :project_ids,
          :funding_method, :cost_center, :funding_status, :budget_allocated,
          :priority, :start_date, :end_date, :risk_rating, :risks, :projected_revenue
      )
    end
end
