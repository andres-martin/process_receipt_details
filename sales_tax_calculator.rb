class SalesTaxCalculator
  class SalesTaxError < StandardError; end

  attr_reader :basic_tax_rate, :import_duty_rate, :exempt_categories

  def initialize(basic_tax_rate: 0.10, import_duty_rate: 0.05, exempt_categories: %w[book food medical])
    @basic_tax_rate = basic_tax_rate
    @import_duty_rate = import_duty_rate
    @exempt_categories = exempt_categories.freeze
  end

  # Calculate tax for multiple items
  # @param items [Array<Item>] Items to calculate tax for
  # @return [Array<Hash>] Tax calculation results
  def calculate_sales_tax(items)
    items.map do |item|
      begin
        calculate(item.price, item.quantity, item.name, item.category, item.imported)
      rescue SalesTaxError => e
        puts "Error calculating sales tax for item '#{item.name}': #{e.message}"
        nil
      end
    end.compact
  end

  # Calculate tax for a single item
  # @param price [Numeric] The price of the item
  # @param quantity [Integer] The quantity of the item
  # @param item_name [String] The name of the item
  # @param category [String] The category of the item
  # @param imported [Boolean] Whether the item is imported
  # @return [Hash] Tax calculation results
  def calculate(price, quantity, item_name, category, imported = false)
    validate_inputs(price, item_name)
    exempt = exempt_from_basic_tax?(category)

    basic_tax = exempt ? 0 : round_tax(price * @basic_tax_rate)
    import_tax = imported ? round_tax(price * @import_duty_rate) : 0

    total_tax = basic_tax + import_tax
    total_amount = price + total_tax

    {
      item_name: item_name,
      quantity: quantity,
      basic_tax: (basic_tax * quantity).round(2),
      import_tax: (import_tax * quantity).round(2),
      total_tax: (total_tax * quantity).round(2),
      total_amount: (total_amount * quantity).round(2),
    }
  end

  private

  def validate_inputs(price, item_name)
    raise SalesTaxError, 'Price must be a positive number' unless price.is_a?(Numeric) && price.positive?
    raise SalesTaxError, 'Item name must be a non-empty string' unless item_name.is_a?(String) && !item_name.empty?
  end

  def exempt_from_basic_tax?(category)
    @exempt_categories.include?(category)
  end

  def round_tax(amount)
    (amount * 20).ceil / 20.0
  end
end
