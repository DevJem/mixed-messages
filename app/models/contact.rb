class Contact < ActiveRecord::Base
 validates :title, presence: true
 validates :content, presence: true, length: {minimum: 5, maximum: 4000}
 

end
