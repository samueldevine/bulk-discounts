class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :percentage, presence: true, numericality: { greater_than: 0, less_than: 100 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
