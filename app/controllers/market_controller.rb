class MarketController < ApplicationController

	# def index
	# 	ShopifyAPI::Base.site = get_shop_url

	# 	@shop = ShopifyAPI::Shop.current
	# 	#@products = JSON.load(open(get_shop_url))
	# end


	private

	def get_shop_url
		shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@trial-for-mm.myshopify.com/admin/products.json?fields=id,images,title"	
	end

	
end
# @trial-for-mm.myshopify.com/admin/products.json?fields=id,images,title