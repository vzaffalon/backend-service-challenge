class LocationResponseWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'location-response', auto_delete: true
  
    def perform(sqs_msg, payload)
      json_payload = JSON.parse(payload)
      @order = Order.find(json_payload["order_id"].to_i)
      @order.update_attributes({latitude: json_payload["latitude"], longitude: json_payload["longitude"]})
    end
end