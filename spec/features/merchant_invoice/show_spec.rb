require 'rails_helper'

RSpec.describe "Merchant Invoice Show" do
  it 'shows all invoice items' do
    merchant1 = Merchant.create!(name: "Bob's Burgers")
    customer1 = Customer.create!(first_name: "Teddy", last_name: "Lastname")
    invoice1 = Invoice.create!(customer_id: customer1.id, status: 1)
    item1 = Item.create!(name: "Burger", description: "Burger with fries", unit_price: 3, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Shake", description: "Shake without fries", unit_price: 2, merchant_id: merchant1.id)
    invoiceitem1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
    invoiceitem2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 2, unit_price: item2.unit_price, status: 0)

    visit "merchants/#{merchant1.id}/invoices/#{invoice1.id}"
    save_and_open_page
    
    expect(page).to have_content(item1.name)
    expect(page).to have_content(invoiceitem1.quantity)
    expect(page).to have_content(invoiceitem1.unit_price)
    expect(page).to have_content(invoiceitem1.status)
  end
end



# As a merchant
# When I visit my merchant invoice show page
# Then I see all of my items on the invoice including:
#
# Item name
# The quantity of the item ordered
# The price the Item sold for
# The Invoice Item status
# And I do not see any information related to Items for other merchants
