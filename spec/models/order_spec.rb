require 'environment_helper'

describe Order do
  let(:order_id) { '002-23123-1232' }
  let(:order) { Order.new(id: order_id) }

  it 'has an id' do
    expect(order.id).to eq(order_id)
  end

  context 'when fulfillments are added' do
    let(:fulfillment_one) { Fulfillment.new(order_id: order_id, shipment_date: Date.parse('11-01-2016'), total_price: 1234)}
    let(:fulfillment_two) { Fulfillment.new(order_id: order_id, shipment_date: Date.parse('11-04-2016'), total_price: 4321)}

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
