module BlogHelper

	def remove_images(text)
	  text.gsub(/<img([^>])\S+/, "")
	end
end
