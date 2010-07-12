class CreateConfigSettings < ActiveRecord::Migration
  def self.up
    create_table :config_settings do |t|
      t.string :key
      t.string :value_class
      t.string :value_str
      
      t.timestamps
    end
  end

  def self.down
    drop_table :config_settings
  end
end
