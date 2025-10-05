require_relative Rails.root.join("app", "services", "rates", "client")

# Used to refresh the cache when the app starts. 
client = RatesClient.instance
client.refresh