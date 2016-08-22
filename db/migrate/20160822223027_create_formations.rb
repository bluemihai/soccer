class CreateFormations < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :formations do |t|
      t.string :name
      t.string :image_url
      t.hstore :positions
      t.text :comments
      t.timestamps
    end
  end
end
