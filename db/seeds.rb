# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123123',
    password_confirmation: "123123")
  puts "create user email: #{user.email}"
end

categories = %w[Tsunami, Earthquake, Tornado]
categories.each do |name|
  Category.find_or_create_by(name: name)
  puts "Created category: #{name}"
end

30.times do |i|
  puts "start create #{i} post"
  user = User.all.sample
  post = Post.create(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    user: user,
    categories: Category.all.sample(rand(0..5)),
    address: Faker::Address.full_address
  )
  puts "Created post: #{post.title}"
  rand(0..50).times do
    Comment.create(
      content: Faker::Lorem.sentence,
      user: User.all.sample,
      post: post
    )
  end
  puts "Finish creating post #{i}"
end



