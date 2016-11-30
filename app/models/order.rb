class Order
  include Virtus.model

  attribute :id, String
  attribute :fulfillments, Array[Fulfillment]
  attribute :items, Array[Item]
end