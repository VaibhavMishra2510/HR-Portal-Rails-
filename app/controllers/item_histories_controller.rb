class ItemHistoriesController < ApplicationController
 before_action :set_item, only: [:index, :create]

    def index
    @histories = @item.item_histories.order(issued_date: :desc)
    puts "Hello"
    end
  def create
    @history = @item.item_histories.new(
     employee_name: params[:employee_name],
     issued_date: Date.current)
    if @history.save
      redirect_to item_item_histories_path(@item), notice: "Item successfully assigned to #{params[:employee_name]}."
    else
      redirect_to item_item_histories_path(@item), alert: "Failed to assign item."
    end
  end

   def return_item
     @history = ItemHistory.find(params[:id])

     if @history.update(returned_date: Date.current)
      redirect_to item_item_histories_path(@history.item), 
      notice: "Item successfully returned."
     else
       redirect_to item_item_histories_path(@history.item), 
      alert: "Failed to return item."
     end
   end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
 