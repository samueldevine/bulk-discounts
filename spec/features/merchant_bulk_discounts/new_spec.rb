require 'rails_helper'

RSpec.describe 'The new bulk discount page' do
  before :each do
    @merchant = Merchant.create(name: "Bob's Burgers")
  end

  describe 'displays' do
    it 'a form where I can enter data about the new discount' do
      visit new_merchant_bulk_discount_path(@merchant)

      expect(page).to have_field 'bulk_discount[name]'
      expect(page).to have_field 'bulk_discount[percentage]'
      expect(page).to have_field 'bulk_discount[quantity]'
      expect(page).to have_button 'Create Bulk discount'
    end
  end

  describe 'with valid data' do
    it 'a new discount is created and I am redirected with a success message' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'Name', with: "Friends and Family"
      fill_in 'Percentage', with: 35
      fill_in 'Quantity', with: 1
      click_button 'Create Bulk discount'

      expect(current_path).to eq merchant_bulk_discounts_path(@merchant)
      expect(page).to have_content "Fantastic! You successfully created a new discount."
    end
  end

  describe 'with invalid data' do
    it 'I see an error message and I remain on the current page' do
      visit new_merchant_bulk_discount_path(@merchant)

      fill_in 'Percentage', with: 35
      fill_in 'Quantity', with: 1
      click_button 'Create Bulk discount'

      expect(current_path).to eq merchant_bulk_discounts_path(@merchant)
      expect(page).to have_content "Name can't be blank"
    end
  end
end
