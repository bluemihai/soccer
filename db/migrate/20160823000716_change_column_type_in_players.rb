class ChangeColumnTypeInPlayers < ActiveRecord::Migration[5.0]
  def up
    remove_column :players, :paid
    add_column :players, :paid, :boolean
  end

  def down
    remove_column :players, :paid
    add_column :players, :paid, :string
  end
end
