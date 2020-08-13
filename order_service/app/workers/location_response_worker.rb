class LocationResponseWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'location-response', auto_delete: true
  
    def perform(sqs_msg, name)
      puts Order.first.to_json
    end
end