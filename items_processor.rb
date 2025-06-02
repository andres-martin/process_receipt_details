require_relative 'models/item'

class ItemsProcessor
  class ItemsProcessorError < StandardError; end

  # Processes an array of item strings and returns an array of Item objects
  # @param items_array [Array<String>] Array of item strings to process
  # @return [Array<Item>] Array of Item objects created from the input strings
  # @raise [ItemsProcessorError] If the input is not an array or is empty
  def self.process(items_array)
    raise ItemsProcessorError, "Input must be an array" unless items_array.is_a?(Array)
    raise ItemsProcessorError, "No valid items to process" if items_array.empty?

    items_array.map do |item_string|
      begin
        create_item_from_string(item_string)
      rescue ItemsProcessorError => e
        puts "Error processing item '#{item_string}': #{e.message}"
        nil
      end
    end.compact
  end

  private

  # Parses the item string and creates an Item object
  # @param item_string [String] The string representation of the item
  # @return [Item] An instance of Item
  # @raise [ItemProcessorError] If the item string format is invalid
  # @raise [ItemProcessorError] If the item string is empty
  def self.create_item_from_string(item_string)
    item_string_safe = item_string.strip
    raise ItemsProcessorError, "Item string cannot be empty" if item_string_safe.empty?


    match = item_string_safe.match(/(\d+)\s+(.+?)\s+at\s+([\d.]+)/)
    raise ItemsProcessorError, "Invalid item string format" unless match

    quantity = match[1].to_i
    name = match[2].strip
    price = match[3].to_f
    imported = name.downcase.include?('imported')

    Item.new(name, price, quantity, imported)
  end
end
