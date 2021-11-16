class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  enum status: [ "cancelled", "in progress", "completed" ]

  def self.pending_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).uniq
  end

  def total_revenue(merchant_id)
    Invoice.joins(invoice_items: [item: :merchant])
      .where(id: id)
      .where("merchants.id = #{merchant_id}")
      .select('invoices.*, SUM(invoice_items.unit_price * invoice_items.quantity / 100.0) AS revenue')
      .group(:id)
      .first
      .revenue
  end
end
