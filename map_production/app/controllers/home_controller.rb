class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    @suppliers = Supplier.all
    @connections = Connection.all
    @supplyChains = SupplyChain.all
  end
end
