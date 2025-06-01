require_relative 'purchase_file_reader'

# Get file path from command line arguments
file_path = ARGV[0]

if file_path.nil? || file_path.empty?
  puts "Error: No file path provided."
  puts "Usage: ruby main.rb <path_to_receipt_file>"
  exit(1)
end

begin
  # Read the file and process its contents
  item_lines = PurchaseFileReader.read_file(file_path)
  ReceiptGenerator.generate_receipt(item_lines)


rescue StandardError => e
  puts "Error: #{e.message}"
  exit(1)
end
