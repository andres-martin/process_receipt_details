class ItemParser
  class ParserError < StandardError; end

  # Parse an item string into a hash of attributes
  # @param item_string [String] The string to parse
  # @return [Hash] The extracted attributes
  # @raise [ParserError] If the string can't be parsed
  def parse(item_string)
    item_string_safe = item_string.to_s.strip
    raise ParserError, "Item string cannot be empty" if item_string_safe.empty?

    match = item_string_safe.match(/(\d+)\s+(.+?)\s+at\s+([\d.]+)/)
    raise ParserError, "Invalid item string format" unless match

    quantity = match[1].to_i
    name = match[2].strip
    price = match[3].to_f
    imported = name.downcase.include?('imported')

    {
      name:,
      price:,
      quantity:,
      imported:
    }
  end
end
