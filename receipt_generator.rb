require_relative 'processors/items_processor'
require_relative 'sales_tax_calculator'

class ReceiptGenerator
  def self.generate_receipt(items)
    processor = ItemsProcessor.new
    tax_calculator = SalesTaxCalculator.new

    items_obj = processor.process(items)
    item_taxes = tax_calculator.calculate_sales_tax(items_obj)

    print_formatted_receipt(item_taxes)
  end

  private

  def self.print_formatted_receipt(item_taxes)
    item_taxes.each do |item|
      quantity = item[:quantity]
      name = item[:item_name]

      puts "#{quantity} #{name}: #{format('%.2f', item[:total_amount])}"
    end

    total_taxes = item_taxes.sum { |item| item[:total_tax] }
    total_amount = item_taxes.sum { |item| item[:total_amount] }

    puts "Sales Taxes: #{format('%.2f', total_taxes)}"
    puts "Total: #{format('%.2f', total_amount)}"
  end
end
