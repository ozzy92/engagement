class DepartmentsController < ApplicationController

  def index
    # we are assuming Board of Directors (top level) is #1
    @department = Department.find(1)
  end

  def new
    @department = Department.new
    # departments is used for parent department selector
    @departments = Department.all
  end

  def edit
    @department = Department.find(params[:id])
    # departments is used for parent department selector
    @departments = Department.all
  end

  def create
    # TODO: Validation!  Need to detect loops!  Missing values!
    @department = Department.new(department_params)
    # make sure a cost center value is set (hmm doesn't work :()
    @department.cost_center = CostCentersController.new if @department.cost_center.nil?
    @department.save
    redirect_to departments_path
  end

  def update
    @department = Department.find(params[:id])
    @department.update department_params
    redirect_to departments_path
  end

  private

    def department_params
      params.require(:department).permit(:name, :description, :cost_center, :parent_department_id)
    end
end
