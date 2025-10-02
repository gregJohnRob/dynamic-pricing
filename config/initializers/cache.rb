require_relative Rails.root.join("app", "services", "rates", "client")

client = RatesClient.instance
client.refresh