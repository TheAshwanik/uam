class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.belongs_to :service, foreign_key: true

      t.timestamps
    end
  end
end
