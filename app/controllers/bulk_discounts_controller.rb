class BulkDiscountsController < ApplicationController
  def index
    @merchant = find_merchant
  end

  def show
    @merchant = find_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = find_merchant
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    @merchant = find_merchant
    @bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
      flash[:notice] = "Fantastic! You successfully created a new discount."
    else
      flash[:alert] = "#{@bulk_discount.errors.full_messages}"
      render :new
    end
  end

  def edit
    @merchant = find_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = find_merchant
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
      flash[:notice] = "You successfully updated this discount."
    else
      flash[:alert] = "#{@bulk_discount.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    @merchant = find_merchant
    bulk_discount = BulkDiscount.find(params[:id])

    bulk_discount.delete
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percentage, :quantity)
  end

  def find_merchant
    Merchant.find(params[:merchant_id])
  end
end
