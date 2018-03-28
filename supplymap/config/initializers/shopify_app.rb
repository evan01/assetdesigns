ShopifyApp.configure do |config|
  config.application_name = "Supply Chain Map"
  config.api_key = "187855b1177221dd68be75a3ad86223d"
  config.secret = "3a38d4ee00679a1e3715753794d8c604"
  config.scope = "read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
