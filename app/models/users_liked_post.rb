# frozen_string_literal: true

class UsersLikedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # tuple (user_id,post_id) must be unique
  validates :user_id, uniqueness: {
    scope: :post_id
  }
end
