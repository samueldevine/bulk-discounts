require 'rails_helper'

RSpec.describe 'The edit bulk discount page' do
  before :each do
    @merchant = Merchant.create(name: "Bob's Burgers")
    @discount = @merchant.bulk_discounts.create(
      name: "Bob's BOGO Discount",
      percentage: 50,
      quantity: 2
    )
  end

  describe 'displays' do
    it 'a form where I can change data about the discount' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount)

      expect(page).to have_field 'bulk_discount[name]'
      expect(page).to have_field 'bulk_discount[percentage]'
      expect(page).to have_field 'bulk_discount[quantity]'
      expect(page).to have_button 'Update Bulk discount'
    end
  end

  describe 'with valid data' do
    it 'the discount is updated and I am redirected with a success message' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount)

      fill_in 'Name', with: "Friends and Family"
      fill_in 'Percentage', with: 35
      fill_in 'Quantity', with: 1
      click_button 'Update Bulk discount'

      expect(current_path).to eq merchant_bulk_discount_path(@merchant, @discount)
      expect(page).to have_content 'You successfully updated this discount.'
      expect(page).to have_content 'Friends and Family'
      expect(page).to have_content '35.000% off of'
      expect(page).to have_content 'orders with 1 or more items'
    end
  end

  describe 'with invalid data' do
    it 'I see an error message and I remain on the current page' do
      visit edit_merchant_bulk_discount_path(@merchant, @discount)

      fill_in 'Percentage', with: 350
      click_button 'Update Bulk discount'

      expect(current_path).to eq merchant_bulk_discount_path(@merchant, @discount)
      expect(page).to have_content "Percentage must be less than 100"
    end
  end
end
