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
    id = params[:id]
    if ["1", "2"].include? id
      # don't allow edit to board and c-suite
      redirect_to departments_path
    else
      @department = Department.find(id)
      # departments is used for parent department selector
      @departments = Department.all
    end
  end

  def create
    @department = Department.new(department_params)
    # make sure a cost center value is set
    @department.cost_center = CostCentersController.new.new_cost_center if @department.cost_center.blank?
    if @department.save
      redirect_to departments_path
    else
      # departments is used for parent department selector
      @departments = Department.all
      render 'new'
    end
  end

  def update
    id = params[:id]
    if ["1", "2"].include? id
      # don't allow edit to board and c-suite
      redirect_to departments_path
    else
      @department = Department.find(params[:id])
      # departments is used for parent department selector when rendering edit
      @departments = Department.all
      if @department.id.to_s == params[:department][:parent_department_id]
        @department.errors.add(:parent_department_id, "can't be it's own parent")
        render 'edit'
      elsif detect_loop
        @department.errors.add(:parent_department_id, "can't be a descendent from this department")
        render 'edit'
      elsif @department.update(department_params)
        redirect_to departments_path
      else
        render 'edit'
      end
    end
  end

  private

    def department_params
      params.require(:department).permit(:name, :description, :cost_center, :parent_department_id)
    end

    def detect_loop
      # validate that we are not creating a loop!
      parents = [params[:id].to_i]
      parent_id = params[:department][:parent_department_id].to_i
      parent = Department.find(parent_id)
      while true
        if parent.id == 1
          # found the board, this is ok
          return false
        elsif parents.include? parent.id
          return true
        end
        parents.append parent.id
        parent = parent.parent_department
      end
    end
end
