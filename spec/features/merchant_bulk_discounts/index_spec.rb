require 'rails_helper'

RSpec.describe 'The merchant bulk discount index' do
  describe 'displays' do
    it 'all of a merchants bulk discounts (including percentage and quantity thresholds)' do
      merchant = Merchant.create(name: "Bob's Burgers")
      discount_1 = merchant.bulk_discounts.create!(
        name: "Bob's BOGO Discount",
        percentage: 50,
        quantity: 2
      )
      discount_2 = merchant.bulk_discounts.create!(
        name: "Lunch for the whole office",
        percentage: 35,
        quantity: 10
      )

      visit merchant_bulk_discounts_path(merchant)

      expect(page).to have_content discount_1.name
      expect(page).to have_content discount_1.percentage
      expect(page).to have_content discount_1.quantity
      expect(page).to have_content discount_2.name
      expect(page).to have_content discount_2.percentage
      expect(page).to have_content discount_2.quantity
    end
  end
end
