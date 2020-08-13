# app/jobs/your_job.rb
class LocationResponseJob < ApplicationJob
    queue_as 'LocationResponse'
  
    def perform(sqs_msg)
        puts "recebeu" + sqs_msg
    end
  end