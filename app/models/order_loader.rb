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
      order.fulfillments = fulfillments.
        reject { |ful| ful['Shipment Date'].nil? }.
        reject { |ful| ful['Carrier Name & Tracking Number'].nil? }.
        map do |fulfillment|
        Fulfillment.new(
          shipment_date: fulfillment['Shipment Date'],
          total_price: fulfillment['Total Charged'],
          tracking_number: fulfillment['Carrier Name & Tracking Number']
        )
      end
      items = items_csv.select { |item| item['Order ID'] == order_id }
      order.items = items.map do |item|
        Item.new(
          title: item['Title'],
          total_price: item['Item Total'],
          tracking_number: item['Carrier Name & Tracking Number']
        )
      end

      order
    end
  end
end
