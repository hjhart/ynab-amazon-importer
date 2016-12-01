class Item
  include Virtus.model

  attribute :title, String
  attribute :total_price, MoneyAttribute
end
