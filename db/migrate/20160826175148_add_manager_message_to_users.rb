class AddManagerMessageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :manager_message, :string
  end
end
