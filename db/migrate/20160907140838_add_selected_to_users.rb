class AddSelectedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :selected, :boolean
  end
end
