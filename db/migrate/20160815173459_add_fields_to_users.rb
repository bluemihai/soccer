class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dob, :date
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :day_phone, :string
    add_column :users, :evening_phone, :string
    add_column :users, :email, :string
    add_column :users, :dl_license_no, :string
    add_column :users, :dl_issuing_state, :string
    add_column :users, :passport_no, :string
    add_column :users, :passport_country, :string
    add_column :users, :league_history, :text
    add_column :users, :liability_waiver_agreed, :boolean
    add_column :users, :pass_id, :integer
  end
end
