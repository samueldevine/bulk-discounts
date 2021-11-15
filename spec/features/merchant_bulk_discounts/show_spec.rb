require 'rails_helper'

RSpec.describe 'The bulk discounts show page' do
  before :each do
    @merchant = Merchant.create(name: "Bob's Burgers")
    @discount = @merchant.bulk_discounts.create!(
      name: "Bob's BOGO Discount",
      percentage: 50,
      quantity: 2
    )
  end

  it 'displays the bulk discounts quantity threshold and percentage discount' do
    visit merchant_bulk_discount_path(@merchant, @discount)

    expect(page).to have_content @discount.name
    expect(page).to have_content @discount.percentage
    expect(page).to have_content @discount.quantity
  end

  it 'displays a link to edit the bulk discount' do
    visit merchant_bulk_discount_path(@merchant, @discount)

    expect(page).to have_link 'Edit this discount'

    click_link 'Edit this discount'

    expect(current_path).to eq edit_merchant_bulk_discount_path(@merchant, @discount)
  end
end
