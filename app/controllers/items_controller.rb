
class ItemsController < ApplicationController
    before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :authorize_admin_or_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_employee_access, only: [:show]
  before_action :filter_documents, only: [:index]
  def index
    # @items = Item.all
    #    Rails.logger.debug(@items.inspect)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if params[:employee_id].to_i == -1
  # Handle "N/A" case here
end
    if @item.save
      redirect_to items_path, notice: "Item successfully created."
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path, notice: "Item successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path, notice: 'Item has been deleted successfully'
    else
      redirect_to items_path, alert: 'Unable to delete the document.'
    end
  end


  private
  def set_item
    @item = Item.find(params[:id])
  end

  # Ensures only admins or HR can create new documents
  def authorize_admin_or_manager
    unless current_user&.role.in?(['admin', 'manager'])
      redirect_to items_path, alert: "You are not authorized to perform this action."
    end
  end

  # Restricts access to an employee's own documents or allows admin/HR access
  def authorize_employee_access
    # Allow admins and HR to access any document
    return if current_user&.role.in?(['admin', 'manager'])

    # Allow employees to access only their own documents
    if current_user&.role == 'employee' && @item.employee_id != current_user.id
      redirect_to items_path, alert: "You are not authorized to access this item."
    end
  end

  # Filters documents based on the role
  def filter_documents
    if current_user&.role.in?(['admin', 'manager'])
      @items = Item.all # Admins and HR see all documents
    elsif current_user&.role == 'employee'
       @items = Item.where(employee_id: current_user.id) # Employees see only their own documents
    else
       @items = Item.none # Unauthorized users see no documents
    end
  end

  # Strong parameters for document creation and updating
  def item_params
    params.require(:item).permit(:sr_no, :name, :price, :employee_id, :issued_date, :returned_date)
  end
end


