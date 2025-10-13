require_relative Rails.root.join("app", "services", "rates", "client")
require 'net/http'

class CacheRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    uri = URI("http://localhost:3000/pricing")
    http = http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path)
    response = http.request(request)
    if response.code == "500"
      logger.error "Failed to refresh cache"
    else 
      logger.info "Successfully refreshed cache"
    end
  end
end
