class Upload < ActiveRecord::Base
	include ActiveModel::Validations

  belongs_to :user
  has_and_belongs_to_many :comments
  has_and_belongs_to_many :tags

  validates :title, presence: true, length: {minimum: 3, maximum: 100}, uniqueness: true
	validates :user_id, presence: true, on: :create
	#validates :note, presence: true, length: {minimum: 10, maximum: 1000}

	mount_uploader :file, FileUploader
	validates :file, presence: true, on: :create
	validates :file, file_size: {less_than: 100.megabytes}

  validates_acceptance_of :upload_terms_and_conditions


	def self.search(search, zip)
		if zip
			where(['zipcode LIKE ?', "%#{zip}%"])
	  elsif search
	  	self.joins("INNER JOIN tags_uploads ON uploads.id = tags_uploads.upload_id").where [ "tag_id = ?", search]
	  else
	    all
	  end
	end
end
