class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def revenue
    quantity * unit_price / 100.0
  end

  def sql_discount_information(merchant_id)
    InvoiceItem.find_by_sql(
      "SELECT
	      MIN(
      CASE
        WHEN invoice_items.quantity >= bulk_discounts.quantity
        THEN invoice_items.quantity * invoice_items.unit_price * (100 - bulk_discounts.percentage) / 10000.0
        ELSE invoice_items.quantity * invoice_items.unit_price / 100.0
      END) AS rev, bulk_discounts.name AS discount_name
      FROM
        invoice_items
        INNER JOIN items ON items.id = invoice_items.item_id
        INNER JOIN merchants ON merchants.id = items.merchant_id
        INNER JOIN bulk_discounts ON bulk_discounts.merchant_id = merchants.id
      WHERE merchants.id = #{merchant_id} AND invoice_items.id = #{id}
      GROUP BY invoice_items.id, discount_name
      ORDER BY rev"
    )
    .first
  end
end
