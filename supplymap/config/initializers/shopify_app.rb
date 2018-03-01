ShopifyApp.configure do |config|
  config.application_name = "Supply Chain Map"
  config.api_key = "187855b1177221dd68be75a3ad86223d"
  config.secret = "edc8c00175d5bf75b96d92cce45b689a"
  config.scope = "read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end

