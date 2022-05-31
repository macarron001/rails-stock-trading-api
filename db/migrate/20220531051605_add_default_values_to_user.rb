class AddDefaultValuesToUser < ActiveRecord::Migration[7.0]

  def self.up
    change_table :users do |t|
      t.change :approved, :boolean, :default => false
    end
    change_table :users do |t|
      t.change :role, :string, :default => 'trader'
    end
    
  end
  def self.down
    change_table :users do |t|
      t.change :approved, :boolean
    end
    change_table :users do |t|
      t.change :role, :string
    end
  end
end
