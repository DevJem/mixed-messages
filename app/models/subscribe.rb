class Subscribe < ActiveRecord::Base
	if Rails.env.production?
		acts_as_copy_target
	end
end
