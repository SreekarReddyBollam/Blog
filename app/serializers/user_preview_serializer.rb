# frozen_string_literal: true

class UserPreviewSerializer < BaseSerializer
  attributes :username

  attribute :self do
    "http://localhost:3000/users/#{object.id}"
  end
end
