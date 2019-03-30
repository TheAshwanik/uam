class CreateServers < ActiveRecord::Migration[5.2]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :server_type
      t.string :role
      t.string :state
      t.string :os
      t.string :os_version
      t.belongs_to :application, foreign_key: true

      t.timestamps
    end
  end
end
