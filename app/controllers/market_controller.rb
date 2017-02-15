class MarketController < ApplicationController

	def index
		shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@trial-for-mm.myshopify.com/admin"
		ShopifyAPI::Base.site = shop_url
		@shop = ShopifyAPI::Shop.current
		@products = ShopifyAPI::Product.all
	end

	def show
		
	end


	private

	def get_shop_url
		


	end

	
end

# https://e4d4b13f4f5534fdf4b3e6827ad60839:83f0e25ab611c8a8fefceb09f09755d1@trial-for-mm.myshopify.com/admin/products.json?fields=id,images,title 
# @trial-for-mm.myshopify.com/admin/products.json?fields=id,images,title 