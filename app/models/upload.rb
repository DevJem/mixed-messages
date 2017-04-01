class Upload < ActiveRecord::Base
	include ActiveModel::Validations
	include Rails.application.routes.url_helpers

  belongs_to :user
  has_and_belongs_to_many :comments
  has_and_belongs_to_many :tags


  before_save do
  	if self.zipcode.nil?
  		self.zipcode = "0"
  	end
  end

  validates :title, presence: true, length: {minimum: 3, maximum: 100}, uniqueness: true
	validates :user_id, presence: true, on: :create
	#validates :note, presence: true, length: {minimum: 10, maximum: 1000}

	mount_uploader :file, FileUploader
  # process_in_background :file, :thumb#, ThumbWorker

	validates :file, presence: true, on: :create
	validates :file, file_size: {less_than: 100.megabytes}

  validates_acceptance_of :upload_terms_and_conditions


	def self.search(search, zip)
		if zip
			where(['cast(zipcode as text) LIKE ?', "%#{zip}%"])
	  elsif search
	  	self.joins("INNER JOIN tags_uploads ON uploads.id = tags_uploads.upload_id").where [ "tag_id = ?", search]
	  else
	    all
	  end
	end

	def to_jq_upload
    { "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.thumb.url,
    "delete_url" => upload_path(:id => id),
    "delete_type" => "DELETE" }
  end
end
