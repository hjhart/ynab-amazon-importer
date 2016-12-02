require 'environment_helper'

describe Item do
  let(:item) { Item.new(title: 'omg this is GREAAAAT', total_price: '$12.32', tracking_number: 'AMZN_US(TBA109359633000)', quantity: 1) }

  it 'has a title' do
    expect(item.title).to eq('omg this is GREAAAAT')
  end

  it 'has a total price' do
    expect(item.total_price).to eq('$12.32'.to_money)
  end

  it 'has a tracking number' do
    expect(item.tracking_number).to eq('AMZN_US(TBA109359633000)')
  end

  it 'has a quantity' do
    expect(item.quantity).to eq(1)
  end

  describe '#memo' do
    context 'when quantity > 1' do
      let(:item) { Item.new(title: 'WaterBottle Extreme', quantity: 2) }
      it 'returns N of title' do
        expect(item.memo).to eq('2 of WaterBottle Extreme')
      end
    end

    context 'when quantity == 1' do
      let(:item) { Item.new(title: 'WaterBottle Extreme', quantity: 1) }

      it 'returns N of title' do
        expect(item.memo).to eq('WaterBottle Extreme')
      end
    end
  end
end
