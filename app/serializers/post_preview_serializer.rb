# frozen_string_literal: true

class PostPreviewSerializer < BaseSerializer
  attributes :id, :title, :post_link, :image_url

  def post_link
    "#{ENV['domain']}users/#{object.user_id}/posts/#{object.id}"
  end
end
