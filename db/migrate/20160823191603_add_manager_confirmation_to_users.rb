class AddManagerConfirmationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :manager_confirmation, :boolean
    add_column :users, :manager_signature, :string
    add_column :users, :manager_signature_date, :date
  end
end
