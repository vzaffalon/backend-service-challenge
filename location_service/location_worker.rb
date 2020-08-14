require_relative "location"

include Location

class LocationWorker
    include Shoryuken::Worker
  
    shoryuken_options queue: 'location', auto_delete: true
  
    def perform(sqs_msg, payload)
      parsed_payload = JSON.parse(payload)
      results = Location.find_location_from_address(parsed_payload["address"])
      if results.nil? or results.first.nil? or results.first.coordinates.nil?
        raise Exception.new "Google maps api not available"
      end
      coordinates = results.first.coordinates
      params = {
        latitude: coordinates[0],
        longitude: coordinates[1],
        order_id: parsed_payload["order_id"].to_i
      }
      Shoryuken::Client.queues('location-response').send_message(params.to_json)
    end
end