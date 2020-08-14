class LocationResponseWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'location-response', auto_delete: true
  
    def perform(sqs_msg, payload)
      Order.set_location(payload)
    end
end