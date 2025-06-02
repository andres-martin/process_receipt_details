require_relative '../sales_tax_calculator'
require_relative '../models/item'

RSpec.describe SalesTaxCalculator do
  describe '.calculate' do
    context 'with exempt items' do
      it 'calculates no basic tax for books' do
        result = SalesTaxCalculator.calculate(12.49, 1, 'book', 'book', false)
        expect(result[:basic_tax]).to eq(0.00)
        expect(result[:import_tax]).to eq(0.00)
        expect(result[:total_tax]).to eq(0.00)
        expect(result[:total_amount]).to eq(12.49)
      end

      it 'calculates no basic tax for food items' do
        result = SalesTaxCalculator.calculate(0.85, 1, 'chocolate bar', 'food', false)
        expect(result[:basic_tax]).to eq(0.00)
        expect(result[:total_amount]).to eq(0.85)
      end

      it 'calculates no basic tax for medical items' do
        result = SalesTaxCalculator.calculate(9.75, 1, 'packet of headache pills', 'medical', false)
        expect(result[:basic_tax]).to eq(0.00)
        expect(result[:total_amount]).to eq(9.75)
      end
    end

    context 'with non-exempt items' do
      it 'calculates 10% basic tax for other items' do
        result = SalesTaxCalculator.calculate(14.99, 1, 'music CD', 'other', false)
        expect(result[:basic_tax]).to eq(1.50)
        expect(result[:total_tax]).to eq(1.50)
        expect(result[:total_amount]).to eq(16.49)
      end
    end

    context 'with imported items' do
      it 'calculates import duty for imported exempt items' do
        result = SalesTaxCalculator.calculate(10.00, 1, 'imported box of chocolates', 'food', true)
        expect(result[:basic_tax]).to eq(0.00)
        expect(result[:import_tax]).to eq(0.50)
        expect(result[:total_tax]).to eq(0.50)
        expect(result[:total_amount]).to eq(10.50)
      end

      it 'calculates both taxes for imported non-exempt items' do
        result = SalesTaxCalculator.calculate(47.50, 1, 'imported bottle of perfume', 'other', true)
        expect(result[:basic_tax]).to eq(4.75)
        expect(result[:import_tax]).to eq(2.40)
        expect(result[:total_tax]).to eq(7.15)
        expect(result[:total_amount]).to eq(54.65)
      end
    end

    context 'with multiple quantities' do
      it 'multiplies taxes and amounts by quantity' do
        result = SalesTaxCalculator.calculate(11.25, 3, 'imported box of chocolates', 'food', true)
        expect(result[:import_tax]).to eq(1.80)
        expect(result[:total_tax]).to eq(1.80)
        expect(result[:total_amount]).to eq(35.55)
      end
    end

    context 'with invalid inputs' do
      it 'raises error for negative price' do
        expect {
          SalesTaxCalculator.calculate(-10.00, 1, 'book', 'book', false)
        }.to raise_error(SalesTaxCalculator::SalesTaxError, 'Price must be a positive number')
      end

      it 'raises error for empty item name' do
        expect {
          SalesTaxCalculator.calculate(10.00, 1, '', 'book', false)
        }.to raise_error(SalesTaxCalculator::SalesTaxError, 'Item name must be a non-empty string')
      end
    end
  end

  describe '.calculate_sales_tax' do
    it 'processes an array of items' do
      book = double('Item', name: 'book', price: 12.49, quantity: 1, category: 'book', imported: false)
      cd = double('Item', name: 'music CD', price: 14.99, quantity: 1, category: 'other', imported: false)
      chocolate = double('Item', name: 'chocolate bar', price: 0.85, quantity: 1, category: 'food', imported: false)

      items = [book, cd, chocolate]
      result = SalesTaxCalculator.calculate_sales_tax(items)

      expect(result.size).to eq(3)
      expect(result[0][:total_tax]).to eq(0.00)
      expect(result[1][:total_tax]).to eq(1.50)
      expect(result[2][:total_tax]).to eq(0.00)
    end
  end
end
