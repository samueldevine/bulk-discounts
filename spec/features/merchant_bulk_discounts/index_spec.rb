require 'rails_helper'

RSpec.describe 'The merchant bulk discount index' do
  describe 'displays' do
    before :each do
      @merchant = Merchant.create(name: "Bob's Burgers")
    end

    it 'all of a merchants bulk discounts (including percentage and quantity thresholds)' do
      discount_1 = @merchant.bulk_discounts.create!(
        name: "Bob's BOGO Discount",
        percentage: 50,
        quantity: 2
      )
      discount_2 = @merchant.bulk_discounts.create!(
        name: "Lunch for the whole office",
        percentage: 35,
        quantity: 10
      )

      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_content discount_1.name
      expect(page).to have_content discount_1.percentage
      expect(page).to have_content discount_1.quantity
      expect(page).to have_content discount_2.name
      expect(page).to have_content discount_2.percentage
      expect(page).to have_content discount_2.quantity
    end

    it "an 'Upcoming Holidays' section" do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_content 'Upcoming Holidays'
    end

    it 'a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant)

      expect(page).to have_link 'Create a new discount'

      click_link 'Create a new discount'

      expect(current_path).to eq new_merchant_bulk_discount_path(@merchant)
      save_and_open_page
    end
  end
end
