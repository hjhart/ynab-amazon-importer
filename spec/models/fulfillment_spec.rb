require 'environment_helper'

describe Fulfillment do
  let(:fulfillment) { Fulfillment.new(shipment_date: '11/05/16', total_price: '$12.34', tracking_number: 'AMZN_US(TBA109359633000)') }

  context 'when it has a shipment date' do
    it 'has a shipment date' do
      expect(fulfillment.shipment_date).to be_a(Date)
      expect(fulfillment.shipment_date).to eq(Date.parse('2016-11-05'))
    end
  end

  context 'when it does not have a shipment date' do
    let(:fulfillment) { Fulfillment.new(shipment_date: nil) }

    it 'plays it cool' do
      expect(fulfillment.shipment_date).to be nil
    end
  end

  it 'has a total cost' do
    expect(fulfillment.total_price).to eq(Money.new(1234))
    expect(fulfillment.total_price).to be_a(Money)
  end

  it 'has a tracking number' do
    expect(fulfillment.tracking_number).to eq('AMZN_US(TBA109359633000)')
  end
end
