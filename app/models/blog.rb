class Blog < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :comments


  validates :title, presence: true, length: {minimum: 3}, uniqueness: true
	validates :user_id, presence: true
	validates :content, presence: true, length: {minimum: 10}
end
