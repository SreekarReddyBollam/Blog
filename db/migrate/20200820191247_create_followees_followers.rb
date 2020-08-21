# frozen_string_literal: true

class CreateFolloweesFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followees_followers, id: false do |t|
      t.references :followee, foreign_key: { to_table: :users }
      t.references :follower, foreign_key: { to_table: :users }
    end
  end
end
