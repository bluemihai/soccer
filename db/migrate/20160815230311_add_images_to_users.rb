class AddImagesToUsers < ActiveRecord::Migration[5.0]
  def up
    add_attachment :users, :photo
    add_attachment :users, :license_photo
  end

  def down
    remove_attachment :users, :photo
    remove_attachment :users, :license_photo
  end
end
