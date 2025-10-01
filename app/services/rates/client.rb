require 'net/http'
require 'json'
require 'time'

class RatesClient
    include Singleton
    
    def self.instance
      @@instance ||= new
    end
  
    def initialize 
      uri = URI("http://rates:8080/pricing")
      @http = http = Net::HTTP.new(uri.host, uri.port)
      @token = "04aa6f42aa03f220c2ae9a276cd68c62" #TODO: Move to config
    end

    def pricing
      request = Net::HTTP::Post.new("/pricing", {'Content-Type' => 'application/json', 'token' => '04aa6f42aa03f220c2ae9a276cd68c62'})
      body = {
        "attributes": [
          {"period": "Summer", "hotel": "FloatingPointResort", "room": "SingletonRoom"},
          {"period": "Summer", "hotel": "FloatingPointResort", "room": "BooleanTwin"},
          {"period": "Summer", "hotel": "FloatingPointResort", "room": "RestfulKing"},
          {"period": "Summer", "hotel": "GitawayHotel", "room": "SingletonRoom"},
          {"period": "Summer", "hotel": "GitawayHotel", "room": "BooleanTwin"},
          {"period": "Summer", "hotel": "GitawayHotel", "room": "RestfulKing"},
          {"period": "Summer", "hotel": "RecursionRetreat", "room": "SingletonRoom"},
          {"period": "Summer", "hotel": "RecursionRetreat", "room": "BooleanTwin"},
          {"period": "Summer", "hotel": "RecursionRetreat", "room": "RestfulKing"},
          {"period": "Autumn", "hotel": "FloatingPointResort", "room": "SingletonRoom"},
          {"period": "Autumn", "hotel": "FloatingPointResort", "room": "BooleanTwin"},
          {"period": "Autumn", "hotel": "FloatingPointResort", "room": "RestfulKing"},
          {"period": "Autumn", "hotel": "GitawayHotel", "room": "SingletonRoom"},
          {"period": "Autumn", "hotel": "GitawayHotel", "room": "BooleanTwin"},
          {"period": "Autumn", "hotel": "GitawayHotel", "room": "RestfulKing"},
          {"period": "Autumn", "hotel": "RecursionRetreat", "room": "SingletonRoom"},
          {"period": "Autumn", "hotel": "RecursionRetreat", "room": "BooleanTwin"},
          {"period": "Autumn", "hotel": "RecursionRetreat", "room": "RestfulKing"},
          {"period": "Winter", "hotel": "FloatingPointResort", "room": "SingletonRoom"},
          {"period": "Winter", "hotel": "FloatingPointResort", "room": "BooleanTwin"},
          {"period": "Winter", "hotel": "FloatingPointResort", "room": "RestfulKing"},
          {"period": "Winter", "hotel": "GitawayHotel", "room": "SingletonRoom"},
          {"period": "Winter", "hotel": "GitawayHotel", "room": "BooleanTwin"},
          {"period": "Winter", "hotel": "GitawayHotel", "room": "RestfulKing"},
          {"period": "Winter", "hotel": "RecursionRetreat", "room": "SingletonRoom"},
          {"period": "Winter", "hotel": "RecursionRetreat", "room": "BooleanTwin"},
          {"period": "Winter", "hotel": "RecursionRetreat", "room": "RestfulKing"},
          {"period": "Spring", "hotel": "FloatingPointResort", "room": "SingletonRoom"},
          {"period": "Spring", "hotel": "FloatingPointResort", "room": "BooleanTwin"},
          {"period": "Spring", "hotel": "FloatingPointResort", "room": "RestfulKing"},
          {"period": "Spring", "hotel": "GitawayHotel", "room": "SingletonRoom"},
          {"period": "Spring", "hotel": "GitawayHotel", "room": "BooleanTwin"},
          {"period": "Spring", "hotel": "GitawayHotel", "room": "RestfulKing"},
          {"period": "Spring", "hotel": "RecursionRetreat", "room": "SingletonRoom"},
          {"period": "Spring", "hotel": "RecursionRetreat", "room": "BooleanTwin"},
          {"period": "Spring", "hotel": "RecursionRetreat", "room": "RestfulKing"}
        ]
      }.to_json
      request.body = body
      response = @http.request(request)
      response_body = JSON.parse(response.body)
      response_body['rates']
    end

end
