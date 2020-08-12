class LocationWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'Location', auto_delete: true
  
    def perform(sqs_msg, name)
      puts "Hello, #{name}"
    end
end