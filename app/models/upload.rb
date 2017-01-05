class Upload < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
	validates :user_id, presence: true
	validates :note, presence: true, length: {minimum: 10, maximum: 250}
end
