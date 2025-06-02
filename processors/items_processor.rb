require_relative '../models/item'
require_relative '../parsers/item_parser'

class ItemsProcessor
  class ItemsProcessorError < StandardError; end

  # @param parser [ItemParser] The parser to use for creating items
  # @param item_class [Class] The class to use for item instances
  def initialize(parser: nil, item_class: Item)
    @parser = parser || ItemParser.new
    @item_class = item_class
  end

  # Processes an array of item strings and returns an array of Item objects
  # @param items_array [Array<String>] Array of item strings to process
  # @return [Array<Item>] Array of Item objects created from the input strings
  # @raise [ItemsProcessorError] If the input is not an array or is empty
  def process(items_array)
    validate_input(items_array)

    items_array.map do |item_string|
      begin
        create_item_from_string(item_string)
      rescue StandardError => e
        puts "Error processing item '#{item_string}': #{e.message}"
        nil
      end
    end.compact
  end

  private

  def validate_input(items_array)
    raise ItemsProcessorError, "Input must be an array" unless items_array.is_a?(Array)
    raise ItemsProcessorError, "No valid items to process" if items_array.empty?
  end

  # Creates an Item object from a string
  # @param item_string [String] The string representation of the item
  # @return [Item] An instance of Item
  def create_item_from_string(item_string)
    attributes = @parser.parse(item_string)
    @item_class.new(
      attributes[:name],
      attributes[:price],
      attributes[:quantity],
      attributes[:imported]
    )
  end
end
