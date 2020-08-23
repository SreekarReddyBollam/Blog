# frozen_string_literal: true

class UserSerializer < BaseSerializer
  has_many :posts, serializer: PostPreviewSerializer

  attributes :id, :username, :bio, :profile_pic

  attribute :first_name, if: :current_user?
  attribute :last_name, if: :current_user?
  attribute :followers, if: :current_user?
  attribute :following, if: :current_user?

  attribute :links do
    id = object.id
    {
      self: "#{ENV['domain']}users/#{id}",
      posts: "#{ENV['domain']}users/#{id}/posts"
    }
  end

  def followers
    object.followers.map do |follower|
      "#{ENV['domain']}users/#{follower.id}"
    end
  end

  def following
    object.following.map do |followee|
      "#{ENV['domain']}users/#{followee.id}"
    end
  end

  def current_user?
    User.current_user&.id == object.id
  end
end
