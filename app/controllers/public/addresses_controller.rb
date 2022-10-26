class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def address_params
      params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end
end
