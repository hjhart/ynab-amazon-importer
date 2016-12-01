require 'environment_helper'

describe Item do
  let(:item) { Item.new(title: 'omg this is GREAAAAT', total_price: '$12.32', tracking_number: 'AMZN_US(TBA109359633000)') }

  it 'has a title' do
    expect(item.title).to eq('omg this is GREAAAAT')
  end

  it 'has a total price' do
    expect(item.total_price).to eq('$12.32'.to_money)
  end

  it 'has a tracking number' do
    expect(item.tracking_number).to eq('AMZN_US(TBA109359633000)')
  end
end
