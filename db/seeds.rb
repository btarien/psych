require 'open-uri'

puts 'clearing databases...'
User.destroy_all

puts 'creating users...'
alice = User.create!(name: 'Alice', email: 'alice@example.com', password: '123456')
alice.avatar.attach(io: URI.open('https://source.unsplash.com/i8ADlZB2Ijo'), filename: 'alice.jpg', content_type: 'image/jpg')

bob = User.create!(name: 'Bob', email: 'bob@example.com', password: '123456')
bob.avatar.attach(io: URI.open('https://source.unsplash.com/OhKElOkQ3RE'), filename: 'bob.jpg', content_type: 'image/jpg')

carla = User.create!(name: 'Carla', email: 'carla@example.com', password: '123456')
