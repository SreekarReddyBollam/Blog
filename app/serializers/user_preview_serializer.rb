# frozen_string_literal: true

class UserPreviewSerializer < BaseSerializer
  attributes :username

  attribute :self do
    "#{ENV['domain']}users/#{object.id}"
  end
end
