class Order
  include Virtus.model

  attribute :id, String
  attribute :fulfillments, Array[Fulfillment]
  attribute :items, Array[Item]

  def transactions
    transactions = []
    remaining_items = self.items.dup
    self.fulfillments.each do |fulfillment|
      items = TransactionResolver.new(remaining_items: remaining_items, fulfillment: fulfillment).items
      if items.size > 0
        transactions << [fulfillment.shipment_date, 'Amazon.com', nil, items.map(&:title).join(' SPLIT '), fulfillment.total_price, nil]
        items.each { |item| remaining_items.delete(item) }
      else
        transactions << [fulfillment.shipment_date, 'Amazon.com', nil, 'Unknown', fulfillment.total_price, nil]
      end
    end
    transactions
  end
end