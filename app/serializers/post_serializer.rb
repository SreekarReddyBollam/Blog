# frozen_string_literal: true

class PostSerializer < BaseSerializer
  belongs_to :user, serializer: UserPreviewSerializer

  attributes :id, :user_id, :title, :body, :image_url, :created_at, :updated_at, :self, :likes_count, :created_by

  def self
    "#{ENV['domain']}users/#{object.user_id}/posts/#{object.id}"
  end

  def likes_count
    object.likes.count
  end

  def created_by
    object.user.username
  end
end
