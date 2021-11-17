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
  # our current data implies that each invoice can only have 1 merchant
  # if this ever changes, this method will need to be refactored accordingly

    invoice_items.sum do |invoice_item|
      merchant = Merchant.find(Item.find(invoice_item.item_id).merchant_id)
      discounts = merchant.bulk_discounts
      if discounts.empty?
        total_revenue
      else
        invoice_item.sql_discount_information(merchant.id).rev
      end
    end
  end

  def applied_discounts(invoice_item)
  # our current data implies that each invoice can only have 1 merchant
  # if this ever changes, this method will need to be refactored accordingly

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
