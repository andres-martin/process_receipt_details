require_relative '../receipt_generator'

RSpec.describe ReceiptGenerator do
  describe '.generate_receipt' do
    context 'with input example 1' do
      let(:input_items) { [
        '2 book at 12.49',
        '1 music CD at 14.99',
        '1 chocolate bar at 0.85'
      ] }

      it 'generates the correct output' do
        expected_output = [
          "2 book: 24.98",
          "1 music CD: 16.49",
          "1 chocolate bar: 0.85",
          "Sales Taxes: 1.50",
          "Total: 42.32"
        ].join("\n") + "\n"

        expect { ReceiptGenerator.generate_receipt(input_items) }.to output(expected_output).to_stdout
      end
    end

    context 'with input example 2' do
      let(:input_items) { [
        '1 imported box of chocolates at 10.00',
        '1 imported bottle of perfume at 47.50'
      ] }

      it 'generates the correct output' do
        expected_output = [
          "1 imported box of chocolates: 10.50",
          "1 imported bottle of perfume: 54.65",
          "Sales Taxes: 7.65",
          "Total: 65.15"
        ].join("\n") + "\n"

        expect { ReceiptGenerator.generate_receipt(input_items) }.to output(expected_output).to_stdout
      end
    end
  end
end
