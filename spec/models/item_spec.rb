require 'environment_helper'

describe Item do
  let(:item) { Item.new(title: 'omg this is GREAAAAT') }

  it 'has a title' do
    expect(item.title).to eq('omg this is GREAAAAT')
  end
end
