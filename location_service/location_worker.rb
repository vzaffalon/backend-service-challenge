class LocationWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'location', auto_delete: true
  
    def perform(sqs_msg, name)
      Shoryuken::Client.queues('location-response').send_message('test response')
    end
end