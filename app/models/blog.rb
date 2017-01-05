class Blog < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: {minimum: 3, maximum: 50}, uniqueness: true
	validates :user_id, presence: true
	validates :content, presence: true, length: {minimum: 10}
end
