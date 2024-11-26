class DocumentsController < ApplicationController
  before_action :set_document, only: [:edit, :update, :show, :destroy]
  before_action :authorize_admin_or_manager, only: [:new, :create, :show]
  before_action :authorize_employee_access, only: [ :show ]
  before_action :filter_documents, only: [:index]  # Employees can only see their own documents in the index

  def index
    # `@documents` is already filtered in `filter_documents`
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to documents_path, notice: "Document was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to documents_path, notice: 'Document has been updated successfully'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @document.destroy
      redirect_to documents_path, notice: 'Document has been deleted successfully'
    else
      redirect_to documents_path, alert: 'Unable to delete the document.'
    end
  end

  private

  # Finds the document based on the ID in params
  def set_document
    @document = Document.find(params[:id])
  end

  # Ensures only admins or HR can create new documents
  def authorize_admin_or_manager
    unless current_user&.role.in?(['admin', 'manager'])
      redirect_to documents_path, alert: "You are not authorized to perform this action."
    end
  end

  # Restricts access to an employee's own documents or allows admin/HR access
  def authorize_employee_access
    # Allow admins and HR to access any document
    return if current_user&.role.in?(['admin', 'manager'])

    # Allow employees to access only their own documents
    if current_user&.role == 'employee' && @document.employee_id != current_user.id
      redirect_to documents_path, alert: "You are not authorized to access this document."
    end
  end

  # Filters documents based on the role
  def filter_documents
    if current_user&.role.in?(['admin', 'manager'])
      @documents = Document.all # Admins and HR see all documents
    elsif current_user&.role == 'employee'
      @documents = Document.where(employee_id: current_user.id) # Employees see only their own documents
    else
      @documents = Document.none # Unauthorized users see no documents
    end
  end

  # Strong parameters for document creation and updating
  def document_params
    params.require(:document).permit(:name, :doc_type, :employee_id, :image)
  end
end
