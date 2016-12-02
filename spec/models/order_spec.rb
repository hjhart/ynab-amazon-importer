require 'environment_helper'

describe Order do
  let(:order_id) { '002-23123-1232' }
  let(:order) { Order.new(id: order_id) }

  context 'attributes' do
    it 'has an id' do
      expect(order.id).to eq(order_id)
    end

    context 'when fulfillments are added' do
      let(:fulfillment_one) { Fulfillment.new(order_id: order_id, shipment_date: '11/01/16', total_price: 1234)}
      let(:fulfillment_two) { Fulfillment.new(order_id: order_id, shipment_date: '11/04/16', total_price: 4321)}

      before do
        order.fulfillments << fulfillment_one
        order.fulfillments << fulfillment_two
      end

      it 'has many fulfillments' do
        expect(order.fulfillments).to match_array([fulfillment_one, fulfillment_two])
      end
    end

    context 'when items are added' do
      let(:item_one) { Item.new(order_id: order_id, title: 'Furby!')}
      let(:item_two) { Item.new(order_id: order_id, title: 'Tokyo Police Club Album')}

      before do
        order.items << item_one
        order.items << item_two
      end

      it 'has many items' do
        expect(order.items).to match_array([item_one, item_two])
      end
    end
  end

  describe '#transactions' do
    let(:order) { Order.new(id: order_id, fulfillments: [fulfillment], items: items) }
    let(:fulfillment) { Fulfillment.new(shipment_date: '11/01/16', total_price: '$12.34') }
    let(:items) { [Item.new(title: 'Furby!', total_price: '$12.34')] }

    context 'when there are more than one item' do
      let(:items) { [Item.new(title: 'Furby!', total_price: '$11.00'), Item.new(title: 'Furry Butts!', total_price: '$1.34')] }

      it 'changes the memo to say "SPLIT ME!"' do
        resolver = instance_double(TransactionResolver, items: items)
        expect(TransactionResolver).to receive(:new).with(fulfillment: fulfillment, remaining_items: items) { resolver }
        transaction_row = [Date.parse('2016-11-01'),'Amazon.com',nil,'MULTIPLE ITEMS –– Furby! $11.00 Furry Butts! $1.34','$12.34'.to_money, nil]
        expect(order.transactions).to eq([transaction_row])
      end
    end

    it 'correctly matches the shipments to the items memo' do
      resolver = instance_double(TransactionResolver, items: items)
      expect(TransactionResolver).to receive(:new).with(fulfillment: fulfillment, remaining_items: items) { resolver }
      transaction_row = [Date.parse('2016-11-01'),'Amazon.com',nil,'Furby!','$12.34'.to_money, nil]
      expect(order.transactions).to eq([transaction_row])
    end

    context 'when the item is not found' do
      let(:items) { [] }

      it 'labels them as unknown if the items are not found' do
        resolver = instance_double(TransactionResolver, items: [])
        expect(TransactionResolver).to receive(:new).with(fulfillment: fulfillment, remaining_items: items) { resolver }
        transaction_row = [Date.parse('2016-11-01'),'Amazon.com',nil,'Unknown','$12.34'.to_money, nil]
        expect(order.transactions).to eq([transaction_row])
      end
    end
  end
end
