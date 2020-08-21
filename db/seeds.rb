# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create({ first_name: 'John', last_name: 'Adam', password: 'Random@12', username: 'john_adam' })
User.create({ first_name: 'John', last_name: 'Nesham', password: 'Random@12', username: 'john_neesham' })
User.create({ first_name: 'John', last_name: 'Evans', password: 'Random@12', username: 'john_evans' })

FolloweesFollower.create({ followee_id: 1, follower_id: 2 })
FolloweesFollower.create({ followee_id: 1, follower_id: 3 })

Post.create({ title: 'CoffeeLover', image_url: 'localhost', body: 'lorem ipsum', user_id: 1 })
Post.create({ title: 'TeaLover', image_url: 'localhost', body: 'lorem ipsum', user_id: 1 })
Post.create({ title: 'DecafLover', image_url: 'localhost', body: 'lorem ipsum', user_id: 2 })

UsersLikedPost.create({ user_id: 1, post_id: 1 })
UsersLikedPost.create({ user_id: 1, post_id: 2 })
UsersLikedPost.create({ user_id: 2, post_id: 1 })
