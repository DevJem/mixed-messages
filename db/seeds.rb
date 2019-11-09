# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(username: "DevJem", email: "android.devjem@gmail.com", admin: true, password: "password", password_confirmation: "password", require_password_reset: false)
user1 = User.create(username: "guest", email: "test@mailinator.com", admin: true, password: "password", password_confirmation: "password", require_password_reset: false)
blog = Blog.create(user_id: 1, title: "Temporary first blog", content: "Temporary first blog")
comment = Comment.create(title: "comment", comment: "You put the comments here", user_id: 1, blog_id: 1)