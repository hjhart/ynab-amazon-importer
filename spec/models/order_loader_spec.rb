require 'environment_helper'

describe OrderLoader do
  describe '#orders' do
    let(:items_csv) { CSV.parse(File.read('spec/fixtures/amazon_items_simple.csv'), headers: true) }
    let(:shipment_csv) { CSV.parse(File.read('spec/fixtures/amazon_orders_and_shipments_simple.csv'), headers: true) }

    it 'loads up the order, fulfillment, and item data' do
      orders = OrderLoader.new(items_csv: items_csv, shipments_csv: shipment_csv).orders
      expect(orders.size).to eq(1)
      expect(orders.first).to be_a(Order)
      expect(orders.first.fulfillments.size).to eq(2)
      expect(orders.first.fulfillments.first.shipment_date).to eq(Date.parse('November 5th, 2016'))
      expect(orders.first.fulfillments.first.tracking_number).to eq('AMZN_US(TBA109359633000)')
      expect(orders.first.fulfillments.first.total_price).to eq('$15.59'.to_money)
      expect(orders.first.items.size).to eq(3)
      expect(orders.first.items.first.title).to eq("ExOfficio Men's Give-N-Go Boxer,Black,Medium")
      expect(orders.first.items.first.tracking_number).to eq('AMZN_US(TBA109359633000)')
      expect(orders.first.items.first.total_price).to eq("$15.59".to_money)
      expect(orders.first.items.first.quantity).to eq(1)
    end

    context 'when a fulfillment does not have a shipment date' do
      let(:shipment_csv) { CSV.parse(File.read('spec/fixtures/amazon_orders_and_shipments_missing_shipment_date.csv'), headers: true) }

      it 'skips the fulfillment' do
        orders = OrderLoader.new(items_csv: items_csv, shipments_csv: shipment_csv).orders
        expect(orders.size).to eq(1)
        expect(orders.first).to be_a(Order)
        expect(orders.first.fulfillments).to be_empty
      end
    end

    context 'when a fulfillment does not have a tracking number' do
      let(:shipment_csv) { CSV.parse(File.read('spec/fixtures/amazon_orders_and_shipments_missing_tracking_number.csv'), headers: true) }

      it 'skips the fulfillment' do
        orders = OrderLoader.new(items_csv: items_csv, shipments_csv: shipment_csv).orders
        expect(orders.size).to eq(1)
        expect(orders.first).to be_a(Order)
        expect(orders.first.fulfillments).to be_empty
      end
    end
  end
end
