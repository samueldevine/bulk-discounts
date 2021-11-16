class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def revenue
    quantity * unit_price / 100.0
  end
end
