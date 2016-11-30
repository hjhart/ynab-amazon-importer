require_relative '../../config/environment'
require 'spec_helper'

describe Fulfillment do
  let(:fulfillment) { Fulfillment.new(shipment_date: '2016-11-02') }
  it 'has a shipment date' do
    expect(fulfillment.shipment_date).to be_a(Date)
    expect(fulfillment.shipment_date).to eq(Date.parse('2016-11-02'))
  end
end
