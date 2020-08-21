# frozen_string_literal: true

class UserSerializer < BaseSerializer
  has_many :posts, serializer: PostPreviewSerializer

  attributes :id, :username, :first_name, :last_name, :followers, :following

  attribute :links do
    id = object.id
    {
      self: "http://localhost:3000/users/#{id}",
      posts: "http://localhost:3000/users/#{id}/posts"
    }
  end

  def followers
    object.followers.map do |follower|
      "http://localhost:3000/users/#{follower.id}"
    end
  end

  def following
    object.following.map do |followee|
      "http://localhost:3000/users/#{followee.id}"
    end
  end
end
