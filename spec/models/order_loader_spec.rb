require 'environment_helper'

describe OrderLoader do
  describe '#orders' do
    let(:items_csv) { CSV.parse(File.read('spec/fixtures/amazon_items_simple.csv'), headers: true) }
    let(:shipment_csv) { CSV.parse(File.read('spec/fixtures/amazon_orders_and_shipments_simple.csv'), headers: true) }

    it 'DOES SOMETHING?!?!?!' do
      orders = OrderLoader.new(items_csv: items_csv, shipments_csv: shipment_csv).orders
      expect(orders.size).to eq(1)
      expect(orders.first).to be_a(Order)
      expect(orders.first.fulfillments.size).to eq(2)
      expect(orders.first.items.size).to eq(3)
    end
  end
end
