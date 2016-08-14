class CreateDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :divisions do |t|
      t.string :letter
      t.integer :age

      t.timestamps
    end
  end
end
