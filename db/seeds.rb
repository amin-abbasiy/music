# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "AminMindMan",
#              email: "Mindman@amin.com",
#              password: "AminPass",
#              password_confirmation: "AminPass",
#              activated: true,
#              admin: true)
# 99.times do |n|
#    name = "amin#{n}"
#    email = "mail#{n}@amin.com"
#    password = "password"
#    User.create!(name: name,
#                 email: email,
#                 password: password,
#                 password_confirmation: password) 
# end

# 99.times do |n|
#    User.update(activated: true)
# end
# users = User.order(:id).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.songs.create!(content: content) }
# end

# user = User.find(65)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   user.songs.create!(content: content)
# end

# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }

# user = User.find(3)
# song = User.first.songs.first
# 10.times do
#     content = Faker::Lorem.sentence(5)
#     Comment.create!(content: content,
#                    song_id: song.id,
#                    user_id: user.id)
# end

# categories = ["pop", "rap", "rock", "metal", "hiphop", "old"]

# categories.each do |category|
#    Category.create!(name: category)
# end