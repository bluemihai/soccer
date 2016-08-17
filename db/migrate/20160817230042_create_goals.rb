class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :scorer_id
      t.integer :assister_id
      t.integer :struck_with
      t.integer :minute
      t.text :details

      t.timestamps
    end
  end
end
