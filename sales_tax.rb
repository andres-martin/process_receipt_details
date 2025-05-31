class SalesTax
  BASIC_TAX_RATE = 0.10
  IMPORT_DUTY_RATE = 0.05
  EXEMPT_CATEGORIES = %w[book food medical].freeze

  class SalesTaxError < StandardError; end

  # Calculates the sales tax for a given price and item name
  # @param price [Numeric] The price of the item
  # @param item_name [String] The name of the item
  # @param imported [Boolean] Whether the item is imported
  # @return [Hash] A hash containing the basic tax, import tax, total tax, and total amount
  # @raise [SalesTaxError] If the price is not a positive number

  def self.calculate(price, item_name, imported = false)
    raise SalesTaxError, 'Price must be a positive number' unless price.is_a?(Numeric) && price.positive?

    exempt = exempt_from_basic_tax?(item_name)

    basic_tax = exempt ? 0 : round_tax(price * BASIC_TAX_RATE)
    import_tax = imported ? round_tax(price * IMPORT_DUTY_RATE) : 0

    total_tax = basic_tax + import_tax
    total_amount = price + total_tax

    {
      basic_tax:,
      import_tax:,
      total_tax:,
      total_amount:
    }
  end

  private

  def self.exempt_from_basic_tax?(item_name)
    EXEMPT_CATEGORIES.any? { |category| item_name.downcase.include?(category) }
  end

  # Rounds the tax amount to the nearest 0.05
  # This is done by multiplying by 20, taking the ceiling, and dividing by 20
  # This ensures that the tax is rounded up to the nearest 0.05
  # Example: 0.06 becomes 0.10, 0.11 becomes 0.15

  def self.round_tax(amount)
    (amount * 20).ceil / 20.0
  end
end
