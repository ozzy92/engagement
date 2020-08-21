class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    # my employee structure seems slow, need to load joins to job/title/location
    @employees = Employee.all
    if params[:filter]
      filter = params[:filter].downcase
      # is this a good way?  I don't know!
      @employees = @employees.select do |employee|
        employee.first_name.downcase.include? filter or
            employee.last_name.downcase.include? filter or
            employee.email.downcase.include? filter or
            employee.title.name.downcase.include? filter or
            employee.job.name.downcase.include? filter or
            employee.office.street.downcase.include? filter or
            employee.office.city.downcase.include? filter or
            employee.office.country.downcase.include? filter or
            employee.department.name.downcase.include? filter or
            employee.department.description.downcase.include? filter
      end
      @actions = params[:actions] || 'view'
      respond_to do |format|
        format.js { render partial: 'employee_loader' }
        format.html { render partial: 'employee_list' }
      end
    end
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :password_digest, :title_id, :job_id, :office_id, :department_id)
    end
end
