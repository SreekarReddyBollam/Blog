# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create({first_name: 'John', last_name: 'Adam', password: 'Random@12', username: 'john_adam'})
User.create({first_name: 'John', last_name: 'Nesham', password: 'Random@12', username: 'john_neesham'})
User.create({first_name: 'John', last_name: 'Evans', password: 'Random@12', username: 'john_evans'})

FolloweesFollower.create({followee_id: 1, follower_id: 2})
FolloweesFollower.create({followee_id: 1, follower_id: 3})

Post.create({title: 'CoffeeLover',
             image_url: 'https://images.unsplash.com/photo-1561047029-3000c68339ca',
             body: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
             user_id: 1})
Post.create({title: 'TeaLover', image_url: 'https://static.toiimg.com/thumb/72294806.cms?width=680&height=512&imgsize=670264', body: 'lorem ipsum', user_id: 1})
Post.create({title: 'DecafLover', image_url: 'https://m.media-amazon.com/images/G/31/amazonservices/categories/tea._CB1198675309_._SL1280_FMpng_.png', body: 'lorem ipsum', user_id: 2})

UsersLikedPost.create({user_id: 1, post_id: 1})
UsersLikedPost.create({user_id: 1, post_id: 2})
UsersLikedPost.create({user_id: 2, post_id: 1})
