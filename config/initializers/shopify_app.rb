ShopifyApp.configure do |config|
  config.api_key = "65429a6cb9b52bb165cf6de0c425e831"
  config.secret = "25c37f1721a7f23b59734a6fc6a3121f"
  config.redirect_uri = "http://shopperapproved.herokuapp.com/auth/shopify/callback"
  config.scope = "read_orders, read_products,write_script_tags"
  config.embedded_app = true
end
