class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  enum status: [ "cancelled", "in progress", "completed" ]

  def self.pending_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).uniq
  end

  def total_revenue
    if invoice_items.empty?
      0
    else
      Invoice.joins(:invoice_items)
        .where(id: id)
        .select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price / 100.0) AS revenue')
        .group(:id)
        .first
        .revenue
    end
  end

  def discount_revenue
    if invoice_items.empty?
      0
    else
      discounts = Merchant.find(Item.find(invoice_items.first.item_id).merchant_id).bulk_discounts

      invoice_items.sum do |invoice_item|
        final_discount = 0
        discounts.each do |discount|
          if invoice_item.quantity >= discount.quantity && discount.percentage >
            final_discount
            final_discount = discount.percentage
          end
        end
        invoice_item.quantity * (invoice_item.unit_price / 100.0) * ((100 - final_discount) / 100.0)
      end
    end
  end

  def applied_discounts(invoice_item)
    discounts = Merchant.find(Item.find(invoice_item.item_id).merchant_id).bulk_discounts
    applied_discount = Hash.new

    invoice_items.each do |item|
      final_discount = 0
      discounts.each do |discount|
        if item.quantity >= discount.quantity && discount.percentage > final_discount
          final_discount = discount.percentage
          applied_discount[item] = discount
        end
      end
    end
    if applied_discount[invoice_item]
      "#{applied_discount[invoice_item].name} - #{applied_discount[invoice_item].percentage}% off"
    else
      "N/A"
    end
  end
end
