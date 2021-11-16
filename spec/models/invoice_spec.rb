require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  before :each do
    @merchant = Merchant.create(name: 'Bob Burger')
    @customer = Customer.create(first_name: "Bob", last_name: "Dylan")
    @invoice_1 = @customer.invoices.create(status: 'in progress')
    @invoice_2 = @customer.invoices.create(status: 'completed')
    @item_1 = @merchant.items.create(name: 'book', description: 'good book', unit_price: 1200)
    @item_2 = @merchant.items.create(name: 'spatula', description: 'good spatula', unit_price: 800)
    @invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 2400, status: 'pending')
    @invoice_item_2 = InvoiceItem.create(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 1600, status: 'shipped')
  end

  describe 'class methods' do
    describe '::pending_invoices' do
      it 'returns an array of pending invoices' do
        expect(Invoice.pending_invoices).to eq([@invoice_1])
      end
    end
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'returns the total revenue for a given merchant on an invoice' do
        expect(@invoice_1.total_revenue).to eq 48
        expect(@invoice_2.total_revenue).to eq 32
      end
    end

    describe '#discount_revenue' do
      it 'returns the revenue for a given merchant after valid discounts are applied' do
        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 2)

        expect(@invoice_1.discount_revenue).to eq 24
      end

      it 'applies to all items a merchant sells' do
        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 2)

        expect(@invoice_1.discount_revenue).to eq 24
        expect(@invoice_2.discount_revenue).to eq 16
      end

      it 'applies the valid discount with the greatest percentage savings' do
        @merchant.bulk_discounts.create(name: 'Black Thursday', percentage: 20, quantity: 2)
        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 2)

        expect(@invoice_1.discount_revenue).to eq 24
        expect(@invoice_2.discount_revenue).to eq 16
      end

      it 'only applies to items that meet the quantity threshold' do
        @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 1, unit_price: 2400, status: 'pending')
        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 2)

        expect(@invoice_1.discount_revenue).to eq 48
      end

      it 'item quantities cannot be added together to meet the threshold' do
        @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 1, unit_price: 2400, status: 'pending')
        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 3)

        expect(@invoice_1.discount_revenue).to eq 72
      end
    end

    describe '#applied_discounts' do
      it 'returns a string describing the discounts applied to each invoice item' do
        expect(@invoice_1.applied_discounts(@invoice_item_1)).to eq "N/A"

        @merchant.bulk_discounts.create(name: 'Black Friday', percentage: 50, quantity: 2)

        expect(@invoice_1.applied_discounts(@invoice_item_1)).to eq "Black Friday - 50.0% off"
      end
    end
  end
end
