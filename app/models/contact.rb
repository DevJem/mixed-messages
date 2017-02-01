class Contact < ActiveRecord::Base
 validates :content, presence: true, length: {minimum: 25, maximum: 4000}
 

end
