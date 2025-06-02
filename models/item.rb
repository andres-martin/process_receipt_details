class Item
  attr_reader :name, :price, :quantity, :imported

  class ItemError < StandardError; end

  # @param name [String] The name of the item
  # @param price [Numeric] The unit price of the item
  # @param quantity [Integer] The quantity of the item
  # @param imported [Boolean] Whether the item is imported
  # @raise [ItemError] If any parameters are invalid

  def initialize(name, price, quantity, imported = false)
    validate_params(name, price, quantity, imported)

    @name = name.dup.freeze
    @price = price.to_f.freeze
    @quantity = quantity
    @imported = imported

    freeze
  end

  # Calculate the total price for this item
  # @return The total price
  def total_price
    @price * @quantity
  end

  # Determine the category of the item based on its name
  # @return [String] The category of the item
  def category
    name_lower = @name.downcase

    if name_lower.include?('book')
      'book'
    elsif name_lower.include?('food') || name_lower.include?('chocolate')
      'food'
    elsif name_lower.include?('medical') || name_lower.include?('pill')
      'medical'
    else
      'other'
    end
  end

  private

  # Validate all parameters
  # @raise [ItemError] If any parameters are invalid
  def validate_params(name, price, quantity, imported)
    raise ItemError, 'Name must be a non-empty string' unless name.is_a?(String) && !name.empty?
    raise ItemError, 'Price must be a positive number' unless price.is_a?(Numeric) && price.positive?
    raise ItemError, 'Quantity must be a positive integer' unless quantity.is_a?(Integer) && quantity.positive?
    raise ItemError, 'Imported must be a boolean' unless [true, false].include?(imported)
  end
end
