class LocationWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'Location', auto_delete: true
  
    def perform(sqs_msg, name)
      Shoryuken::Client.queues('LocationResponse').send_message('test response')
    end
end