class MarketController < ApplicationController
 
	def index
		get_shop
		@products = ShopifyAPI::Product.all
	end

	def show
	end

	def orders
		get_shop
		@orders = ShopifyAPI::Order.where(fulfillment_status: "null")
	end

	def mark_fulfilled
		get_shop
		@order = ShopifyAPI::Order.find(fulfillment_params[:order_id])
		@fill = ShopifyAPI::Fulfillment.new(order_id: @order.id, notify_customer: true)
		@fill.prefix_options = {order_id: @order.id}
		@fill.save
		@order.fulfillments << @fill

		if @order.save
			flash[:success] = "Order #{fulfillment_params[:order_number]} marked fulfilled."
			redirect_to :back
			puts "Order Fill: #{@order.fulfillments}"
		else
			flash[:danger] = "Something went wrong. Check Shopify to see what's up with this order."
			render :orders
		end
	end	
 

	private

	def get_shop
		shop_url = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@mixed-messages.myshopify.com/admin"
		ShopifyAPI::Base.site = shop_url
		@shop = ShopifyAPI::Shop.current
	end

	def fulfillment_params
		params.require(:fulfilled).permit(:order_number, :order_id)
	end

end
