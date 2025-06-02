class SalesTaxCalculator
  BASIC_TAX_RATE = 0.10
  IMPORT_DUTY_RATE = 0.05
  EXEMPT_CATEGORIES = %w[book food medical].freeze

  class SalesTaxError < StandardError; end

  def self.calculate_sales_tax(items)
    items.map do |item|
      begin
        calculate(item.price, item.quantity, item.name, item.category, item.imported)
      rescue SalesTaxError => e
        puts "Error calculating sales tax for item '#{item.name}': #{e.message}"
        nil
      end
    end.compact
  end

  # Calculates the sales tax for a given price and item name
  # @param price [Numeric] The price of the item
  # @param item_name [String] The name of the item
  # @param imported [Boolean] Whether the item is imported
  # @return [Hash] A hash containing the basic tax, import tax, total tax, and total amount
  # @raise [SalesTaxError] If the price is not a positive number

  def self.calculate(price, quantity, item_name, category, imported = false)
    validate_inputs(price, item_name)
    exempt = exempt_from_basic_tax?(category)

    basic_tax = exempt ? 0 : round_tax(price * BASIC_TAX_RATE)
    import_tax = imported ? round_tax(price * IMPORT_DUTY_RATE) : 0

    total_tax = basic_tax + import_tax
    total_amount = price + total_tax

    {
      item_name:,
      quantity:,
      basic_tax: (basic_tax * quantity).round(2),
      import_tax: (import_tax * quantity).round(2),
      total_tax: (total_tax * quantity).round(2),
      total_amount: (total_amount * quantity).round(2),
    }
  end

  private

  def self.validate_inputs(price, item_name)
    raise SalesTaxError, 'Price must be a positive number' unless price.is_a?(Numeric) && price.positive?
    raise SalesTaxError, 'Item name must be a non-empty string' unless item_name.is_a?(String) && !item_name.empty?
  end

  def self.exempt_from_basic_tax?(category)
    EXEMPT_CATEGORIES.include?(category)
  end

  # Rounds the tax amount to the nearest 0.05
  # This is done by multiplying by 20, taking the ceiling, and dividing by 20
  # This ensures that the tax is rounded up to the nearest 0.05
  # Example: 0.06 becomes 0.10, 0.11 becomes 0.15

  def self.round_tax(amount)
    (amount * 20).ceil / 20.0
  end
end
