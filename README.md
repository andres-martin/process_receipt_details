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

   ```
   git clone https://github.com/yourusername/process_receipt_details.git
   cd process_receipt_details
   ```

2. Ensure you have Ruby installed (version 2.6 or higher recommended):

   ```
   ruby --version
   ```

3. Install required gems for testing:

   ```
   gem install rspec
   ```

## Usage

### Running the Program

Run the program by providing a path to a receipt file:

```
ruby main.rb path/to/receipt_file.txt
```

### Receipt File Format

Each line in the receipt file should follow this format:

```
[quantity] [item name] at [price]
```

Example:

```
1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

### Output

The program will output a formatted receipt showing:

- Each item with its quantity and tax-inclusive price
- Total sales taxes
- Total amount

Example output:

```
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
```

## Testing

Run the test suite with:

```
rspec
```

Or run specific test files:

```
rspec spec/sales_tax_calculator_spec.rb
rspec spec/receipt_generator_spec.rb
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

```
1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

Output:

```
1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83
```

### Example 2

Input:

```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

Output:

```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```
