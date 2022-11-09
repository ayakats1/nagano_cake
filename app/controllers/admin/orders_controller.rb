class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    Time::DATE_FORMATS[:datetime_jp] = '%Y/ %m/ %d'
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirmation"
         @order.order_details.update_all(making_status: "production_pending")
      end
       redirect_to admin_order_path(@order.id)
    end
  end

   private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code,:address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end