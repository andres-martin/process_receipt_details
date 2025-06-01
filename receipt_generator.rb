require_relative 'items_processor'

class ReceiptGenerator
  # TODO:
  # read purchase file
  # call ItemsProcessor.process to process items from file
  # call SalesTaxCalculator.calculate_sales_tax to calculate sales tax
  # then generate receipt and print it to stdout
  # could create a Receipt class to encapsulate receipt details

  def self.generate_receipt(items)
    ItemsProcessor.process(items)
    SalesTaxCalculator.calculate_sales_tax(items)
  end

  private

  def calculate_total
  end
end
