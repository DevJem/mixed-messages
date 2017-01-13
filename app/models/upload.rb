class Upload < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :comments

  validates :title, presence: true, length: {minimum: 3, maximum: 50}, uniqueness: true
	validates :user_id, presence: true, on: :create
	validates :note, presence: true, length: {minimum: 10, maximum: 1000}

	mount_uploader :file, FileUploader
	validates :file, presence: true, on: :create

end
