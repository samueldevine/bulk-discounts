class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
      flash[:notice] = "Fantastic! You successfully created a new discount."
    else
      flash[:alert] = "#{@bulk_discount.errors.full_messages}"
      render :new
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])

    bulk_discount.delete
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percentage, :quantity)
  end
end
