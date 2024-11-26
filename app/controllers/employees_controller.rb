class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :show, :destroy]
  before_action :authorize_admin_or_manager, only: [:new, :create, :edit, :update]
  before_action :authorize_admin_for_destroy, only: [:destroy]
  before_action :authorize_employee_access, only: [:edit, :update, :show]  # Employees can only access their own record

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "Employee was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee has been updated successfully'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @employee.destroy
      redirect_to employees_path, notice: 'Employee has been deleted successfully'
    else
      redirect_to employees_path, alert: 'Failed to delete employee'
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
    Rails.logger.debug "SET EMPLOYEE: #{@employee.inspect}"
  end

  def authorize_admin_or_manager
    unless current_user&.role.in?(['admin', 'manager'])
      redirect_to employees_path, alert: "You are not authorized to perform this action."
    end
  end

  # Ensure only admins can destroy employees
  def authorize_admin_for_destroy
    unless current_user&.role == 'admin'
      redirect_to employees_path, alert: "Only admins can delete employees."
    end
  end

  def authorize_employee_access
    Rails.logger.debug "CURRENT USER: #{current_user.inspect}"
    Rails.logger.debug "EMPLOYEE TO ACCESS: #{@employee.inspect}"
    return if current_user&.role.in?(['admin', 'manager'])

    if current_user&.role == 'employee' && @employee.id != current_user.id
      redirect_to employees_path, alert: "You are not authorized to access this employee's details."
    end
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :personal_email,
      :city, :state, :country, :pincode,
      :address_line_1, :address_line_2,
      :date_of_birth, :date_of_joining, :job_title, :about
    )
  end
end
