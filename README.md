# Receipt Sales Tax Calculator

This Ruby application processes shopping receipts, calculates sales taxes according to specific rules, and generates formatted receipts.

## Features

- Calculates basic sales tax (10%) and import duty (5%)
- Handles tax exemptions for books, food, and medical products
- Processes receipts from text files
- Formats and displays itemized receipts with tax calculations

## Tax Rules

- Basic sales tax: 10% on all goods except books, food, and medical products
- Import duty: Additional 5% on all imported goods (no exemptions)
- Tax rounding: Sales tax is rounded up to the nearest 0.05

## Installation

1. Clone the repository:

   ```markdown
   git clone https://github.com/yourusername/process_receipt_details.git
   cd process_receipt_details
   ```

2. Ensure you have Ruby installed (version 2.6 or higher recommended):

   ```ruby
   ruby --version
   ```

3. Install required gems for testing:

   ```ruby
   gem install rspec
   ```

## Usage

### Running the Program

Run the program by providing a path to a receipt file:

```ruby
ruby main.rb path/to/receipt_file.txt
```

### Receipt File Format

Each line in the receipt file should follow this format:

```markdown
[quantity] [item name] at [price]
```

Example:

```markdown
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

### Output

The program will output a formatted receipt showing:

- Each item with its quantity and tax-inclusive price
- Total sales taxes
- Total amount

Example output:

```markdown
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

## Testing

Run the test suite with:

```ruby
rspec
```

Or run specific test files:

```ruby
rspec spec/sales_tax_calculator_spec.rb --format documentation
```

## Project Structure

- main.rb: Entry point for the application
- items_processor.rb: Processes item strings into Item objects
- purchase_file_reader.rb: Reads and validates input files
- sales_tax_calculator.rb: Calculates sales taxes based on the rules
- receipt_generator.rb: Formats and outputs the receipt
- item.rb: Item model with properties and category detection
- spec: Contains test files

## Examples

### Example 1

Input:

```markdown
2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

Output:

```markdown
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

### Example 2

Input:

```markdown
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

Output:

```markdown
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```
