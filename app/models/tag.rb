class Tag < ActiveRecord::Base
	has_and_belongs_to_many :uploads

	validates :tag_name, presence: true, uniqueness: {case_sensitive: false}
	before_save {self.tag_name = tag_name.upcase}
end
