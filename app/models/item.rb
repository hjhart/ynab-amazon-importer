class Item
  include Virtus.model

  attribute :title, String
  attribute :total_price, MoneyAttribute
  attribute :tracking_number, String
  attribute :quantity, Integer, default: 1

  def memo
    quantity > 1 ? "#{quantity} of #{title}" : title
  end
end
