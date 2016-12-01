class TransactionResolver
  include Virtus.model

  attribute :remaining_items, Array[Item]
  attribute :fulfillment, Fulfillment

  def items
    self.remaining_items.select { |item| item.tracking_number == fulfillment.tracking_number }
  end
end
