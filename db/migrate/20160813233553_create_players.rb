class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first
      t.string :last
      t.string :city
      t.string :email
      t.string :phone
      t.string :positions
      t.string :keeper
      t.string :attendance_estimate
      t.string :ideal_minutes
      t.string :jersey
      t.integer :status
      t.integer :age
      t.text :why
      t.string :paid
      t.boolean :ebssl_card
      t.boolean :active

      t.timestamps
    end
  end
end
