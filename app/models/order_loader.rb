class OrderLoader
  # pass in CSV objects
  include Virtus.model

  attribute :items_csv
  attribute :shipments_csv

  def orders
    unique_order_ids = self.shipments_csv.map { |shipment| shipment['Order ID'] }.uniq
    unique_order_ids.map do |order_id|
      order = Order.new(order_id: order_id)
      fulfillments = shipments_csv.select { |shipment| shipment['Order ID'] == order_id }
      order.fulfillments = fulfillments.map { |fulfillment| Fulfillment.new(shipment_date: nil, total_price: nil)}
      items = items_csv.select { |item| item['Order ID'] == order_id }
      order.items = items.map { |item| Item.new(title: nil)}
      order
    end
  end
end
