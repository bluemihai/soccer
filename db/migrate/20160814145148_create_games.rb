class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :home_id
      t.integer :away_id
      t.datetime :kickoff
      t.text :referees_report
      t.integer :context
      t.integer :referee_id
      t.integer :field_id
      t.integer :status

      t.timestamps
    end
  end
end
