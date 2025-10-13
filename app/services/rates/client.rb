require 'net/http'
require 'json'
require 'time'
require 'kredis'

class RatesClient
    include Singleton
    
    def initialize 
      uri = URI(Rails.configuration.rates["uri"])
      @http = http = Net::HTTP.new(uri.host, uri.port)
      @token =  Rails.configuration.rates["token"]
      @cache = Kredis.json "pricing", expires_in: 5.minutes
    end

    def refresh 
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
      response_body['rates'].each do |rate|
        key = buildKey(rate['hotel'], rate['period'], rate['room'])
        value = Kredis.integer key, expires_in: 5.minutes
        value.value = rate['rate']
      end
    end

    def pricing(hotel, period, room)
      key = buildKey(hotel, period, room)
      value = Kredis.integer key
      value.value
    end

    private 
    
    def buildKey(hotel, period, room)
      hotel + "_" + period + "_" + room
    end 

end
