require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    describe 'name' do
      it { should validate_presence_of :name }
    end

    describe 'percentage' do
      it { should validate_presence_of :percentage }
      it { should validate_numericality_of :percentage }

      it 'should validate that 0 < percentage <= 100' do
        merchant = Merchant.new(name: "Bob's Burgers")
        discount_1 = merchant.bulk_discounts.new(name: 'a', percentage: 10, quantity: 1)
        discount_2 = merchant.bulk_discounts.new(name: 'a', percentage: 0, quantity: 1)
        discount_3 = merchant.bulk_discounts.new(name: 'a', percentage: 110, quantity: 1)

        expect(discount_1).to be_valid
        expect(discount_2).to_not be_valid
        expect(discount_3).to_not be_valid
      end
    end

    describe 'quantity' do
      it { should validate_presence_of :quantity }
      it { should validate_numericality_of :quantity }

      it 'should validate that quantity is greater than 0' do
        merchant = Merchant.new(name: "Bob's Burgers")
        discount_1 = merchant.bulk_discounts.new(name: 'a', percentage: 10, quantity: 1)
        discount_2 = merchant.bulk_discounts.new(name: 'a', percentage: 10, quantity: 0)

        expect(discount_1).to be_valid
        expect(discount_2).to_not be_valid
      end
    end
  end

  describe 'class methods'
  describe 'instance methods'
end
