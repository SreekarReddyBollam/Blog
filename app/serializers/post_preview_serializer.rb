# frozen_string_literal: true

class PostPreviewSerializer < BaseSerializer
  attributes :id, :title, :post_link

  def post_link
    "#{ENV['domain']}users/#{object.user_id}/posts/#{object.id}"
  end
end
