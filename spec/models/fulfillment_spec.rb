require 'environment_helper'

describe Fulfillment do
  let(:fulfillment) { Fulfillment.new(shipment_date: '2016-11-02', total_price: '$12.34') }

  it 'has a shipment date' do
    expect(fulfillment.shipment_date).to be_a(Date)
    expect(fulfillment.shipment_date).to eq(Date.parse('2016-11-02'))
  end

  it 'has a total cost' do
    expect(fulfillment.total_price).to eq(Money.new(1234))
    expect(fulfillment.total_price).to be_a(Money)
  end
end
