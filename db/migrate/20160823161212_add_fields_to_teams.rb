class AddFieldsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :short, :string
    add_column :teams, :uniform_colors, :string
    add_column :teams, :alternate_colors, :string
    add_column :teams, :field_preference, :string
    add_column :teams, :kick_time_preference, :string
    add_column :teams, :mailing_address, :text
  end
end
