class Order
  include Virtus.model

  attribute :id, String
  attribute :fulfillments, Array[Fulfillment]
  attribute :items, Array[Item]

  def transactions
    remaining_items = self.items.dup
    self.fulfillments.map do |fulfillment|
      items = TransactionResolver.new(remaining_items: remaining_items, fulfillment: fulfillment).items
      if items.size > 1
        memo = 'MULTIPLE ITEMS –– '
        memo += items.map { |item| "#{item.title} #{item.total_price.format}"}.join(' ')
      elsif items.size == 1
        memo = items.first.title
      else
        memo = 'Unknown'
      end

      items.each { |item| remaining_items.delete(item) }
      [fulfillment.shipment_date, 'Amazon.com', nil, memo, fulfillment.total_price, nil]
    end
  end
end