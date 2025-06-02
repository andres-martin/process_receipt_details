require_relative '../../processors/items_processor'
require_relative '../../models/item'

RSpec.describe ItemsProcessor do
  let(:processor) { ItemsProcessor.new }

  describe '#process' do
    context 'with valid input' do
      let(:valid_items) { ['1 book at 12.49', '2 music CDs at 14.99'] }

      it 'returns an array of Item objects' do
        result = processor.process(valid_items)

        expect(result).to be_an(Array)
        expect(result.size).to eq(2)
        expect(result.all? { |item| item.is_a?(Item) }).to be true
      end

      it 'correctly processes item attributes' do
        result = processor.process(valid_items)

        expect(result[0].name).to eq('book')
        expect(result[0].price).to eq(12.49)
        expect(result[0].quantity).to eq(1)
        expect(result[0].imported).to be false

        expect(result[1].name).to eq('music CDs')
        expect(result[1].price).to eq(14.99)
        expect(result[1].quantity).to eq(2)
        expect(result[1].imported).to be false
      end
    end

    context 'with imported items' do
      let(:imported_items) { ['1 imported box of chocolates at 10.00'] }

      it 'correctly identifies imported status' do
        result = processor.process(imported_items)

        expect(result[0].name).to eq('imported box of chocolates')
        expect(result[0].imported).to be true
      end
    end

    context 'with invalid input' do
      it 'raises error when input is not an array' do
        expect { processor.process('not an array') }.to raise_error(ItemsProcessor::ItemsProcessorError, 'Input must be an array')
      end

      it 'raises error when input array is empty' do
        expect { processor.process([]) }.to raise_error(ItemsProcessor::ItemsProcessorError, 'No valid items to process')
      end
    end
  end

  context 'with custom parser' do
    let(:custom_parser) { double('CustomParser') }
    let(:processor) { ItemsProcessor.new(parser: custom_parser) }
    let(:valid_items) { ['1 book at 12.49'] }

    it 'uses the provided parser' do
      expect(custom_parser).to receive(:parse).and_return({
        name: 'book',
        price: 12.49,
        quantity: 1,
        imported: false
      })

      result = processor.process(valid_items)
      expect(result[0].name).to eq('book')
    end
  end
end
