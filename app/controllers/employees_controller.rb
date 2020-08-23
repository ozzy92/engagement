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
      # this will render javascript to load list in browser
      @actions = params[:actions] || 'view'
      respond_to do |format|
        format.js { render partial: 'employee_loader' }
        format.html { render partial: 'employee_list' }
      end
    end
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # I'm not sure what this magic is doing, but it's needed for the json ajax call!
    def set_employee
      @employee = Employee.find(params[:id])
    end

end
