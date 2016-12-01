require 'environment_helper'

describe TransactionResolver do
  context 'simplest case' do
    let(:fulfillment) { Fulfillment.new(shipment_date: '11/01/16', total_price: '$12.34') }
    let(:items) { [item] }
    let(:item) { Item.new(title: 'Furby!', total_price: '$12.34') }

    it 'correctly matches the shipments to the items memo' do
      result = TransactionResolver.new(fulfillment: fulfillment, remaining_items: items).items
      expect(result).to eq([item])
    end
  end

  context 'one fulfillment, three items' do
    let(:fulfillment) { Fulfillment.new(shipment_date: '11/05/16', total_price: '$3.00', tracking_number: 'AMZN_US(TBA109359633000)')}
    let(:items) { [item_one, item_two, item_three] }
    let(:item_one) { Item.new(title: 'Pickles!', total_price: '$1.50', tracking_number: 'AMZN_US(TBA109359633000)') }
    let(:item_two) { Item.new(title: 'Pancakes!', total_price: '$1.50', tracking_number: 'AMZN_US(TBA109359633000)') }
    let(:item_three) { Item.new(title: 'Dickle!', total_price: '$5.00', tracking_number: 'AMZN_US(BUTTS)') }


    it 'correctly matches the shipments to the items memo' do
      result = TransactionResolver.new(fulfillment: fulfillment, remaining_items: items).items
      expect(result).to eq([item_one, item_two])
    end
  end

  context 'when there is no match' do
    let(:fulfillment) { Fulfillment.new(shipment_date: '11/05/16', total_price: '$3.00', tracking_number: 'AMZN_US(TBA109359633000)')}

    it 'returns an empty array' do

      result = TransactionResolver.new(fulfillment: fulfillment, remaining_items: []).items
      expect(result).to be_empty
    end
  end
end