class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.string :name
      t.decimal :percentage, precision: 4, scale: 2
      t.integer :quantity
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
