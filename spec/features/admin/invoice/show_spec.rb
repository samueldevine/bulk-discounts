require 'rails_helper'

RSpec.describe 'Admin Invoice Show page' do
  before do
    @customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
    @merchant = Merchant.create!(name: 'Jen')
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 300, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 2000, merchant_id: @merchant.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice.id, quantity: 10, unit_price: 300, status: 'shipped')
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice.id, quantity: 2, unit_price: 2000, status: 'shipped')
  end

  it 'All the items on the invoice are shown' do
    visit admin_invoices_show_path(@invoice.id)

    expect(page).to have_content('Items:')

    within "#item-id-#{@item1.id}" do
      expect(page).to have_content('Item name: Pumpkin')
      expect(page).to have_content('Quantity of Pumpkin(s) ordered: 10')
      expect(page).to have_content('Total price of the Pumpkin(s): $30.00')
      expect(page).to have_content('Status: shipped')
    end

    within "#item-id-#{@item2.id}" do
      expect(page).to have_content('Item name: Pillow')
      expect(page).to have_content('Quantity of Pillow(s) ordered: 2')
      expect(page).to have_content('Total price of the Pillow(s): $40.00')
      expect(page).to have_content('Status: shipped')
    end
  end

  it 'shows the total revenue that will be generated from this invoice' do
    visit admin_invoices_show_path(@invoice.id)

    expect(page).to have_content('Total revenue before discounts: $70.00')
  end

  it 'shows the discounted revenue that will be generated from this invoice' do
    @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 1)

    visit admin_invoices_show_path(@invoice.id)

    expect(page).to have_content('Total revenue after discounts: $35.00')
  end

  it 'can update the invoice status with a select field' do
    visit admin_invoices_show_path(@invoice.id)

    expect(page).to have_content('Status: completed')

    select "in progress", from: 'status'
    click_button 'Update Invoice Status'

    expect(current_path).to eq(admin_invoices_show_path(@invoice.id))
    expect(page).to have_content('Status: in progress')
  end

  describe 'as an admin' do
    before :each do
      @customer = Customer.create!(first_name: 'Taylor', last_name: 'Swift')
      @invoice = @customer.invoices.create!(status: 'in progress')
    end

    it 'displays information related to the invoice' do
      visit "/admin/invoices/#{@invoice.id}"

      expect(page).to have_content @invoice.id
      expect(page).to have_content @invoice.status
      expect(page).to have_content @invoice.created_at.strftime("%A, %B %-d, %Y")
    end

    it 'also displays the first and last name of the customer' do
      visit "/admin/invoices/#{@invoice.id}"

      expect(page).to have_content @customer.first_name
      expect(page).to have_content @customer.last_name
    end
  end
end
