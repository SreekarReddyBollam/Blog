class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bio, :string, default: ''
    add_column :users, :profile_pic, :string, default: ''
  end
end
