require_relative '../../config/environment'
require 'spec_helper'

describe AmazonOrder do
  let(:amazon_order) { AmazonOrder.new(id: '002-23123-1232') }
  it 'has an id' do
    expect(amazon_order.id).to eq('002-23123-1232')
  end
end
