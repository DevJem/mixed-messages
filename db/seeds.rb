# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(username: "DevJem", email: "android.devjem@gmail.com", admin: true, password: "password", password_confirmation: "password", require_password_reset: true)
user2 = User.create(username: "Matt", email: "mattd@mixed-messages.org", admin: true, password: "password", password_confirmation: "password", require_password_reset: true)
user3 = User.create(username: "Kevin", email: "kevin@mixed-messages.org", admin: true, password: "password", password_confirmation: "password", require_password_reset: true)
blog = Blog.create(user_id: 1, title: "Temporary first blog", content: "Temporary first blog")