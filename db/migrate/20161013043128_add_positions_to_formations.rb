class AddPositionsToFormations < ActiveRecord::Migration[5.0]
  def change
    add_column :formations, :p01, :string
    add_column :formations, :p02, :string
    add_column :formations, :p03, :string
    add_column :formations, :p04, :string
    add_column :formations, :p05, :string
    add_column :formations, :p06, :string
    add_column :formations, :p07, :string
    add_column :formations, :p08, :string
    add_column :formations, :p09, :string
    add_column :formations, :p10, :string
    add_column :formations, :p11, :string
  end
end
