class Item
  include Virtus.model

  attribute :title, String
  attribute :total_price, MoneyAttribute
  attribute :tracking_number, String

end
