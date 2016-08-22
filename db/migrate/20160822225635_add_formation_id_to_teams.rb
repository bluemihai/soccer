class AddFormationIdToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :formation_id, :integer
  end
end
