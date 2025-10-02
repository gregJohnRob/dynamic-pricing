require_relative Rails.root.join("app", "services", "rates", "client")

class CacheRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "REFRESHING CACHE NOW!!!!"
    client = RatesClient.instance
    client.refresh
    puts client.pricing
  end
end
