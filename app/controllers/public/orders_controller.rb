class Public::OrdersController < ApplicationController
  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def new
    @order = Order.new
    @addresses = Address.all
    @address = Address.new
    @customer = current_customer
  end

  def comfirm
    @order = Order.new(order_params)
    @subtotal = 0
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      #@order = Order.new(order_params)
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.purchase_price = cart_item.item.with_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.making = "production_not_possible"
      @order_detail.save!
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complate_path
  end

  def complate
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end
