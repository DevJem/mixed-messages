class Comment < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :uploads
	has_and_belongs_to_many :blogs

	validates :title, presence: true, length: {minimum: 3, maximum: 100}, uniqueness: true
	validates :user_id, presence: true
	validates :comment, presence: true, length: {minimum: 10, maximum: 1500}


end
