# frozen_string_literal: true

class PostSerializer < BaseSerializer
  belongs_to :user, serializer: UserPreviewSerializer

  attributes :id, :user_id, :title, :body, :image_url, :created_at, :updated_at, :self, :likes_count, :created_by

  attribute :is_liked, if: :current_user? do
    liked?
  end

  def self
    "#{ENV['domain']}users/#{object.user_id}/posts/#{object.id}"
  end

  def likes_count
    object.likes.count
  end

  def created_by
    object.user.username
  end

  def liked?
    UsersLikedPost.exists?({ user_id: User.current_user.id, post_id: object.id })
  end

  def current_user?
    User.current_user&.id == object.user_id
  end
end
