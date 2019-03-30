class CreatePlatformDashboardMetrics < ActiveRecord::Migration[5.2]
  def change
    create_table :platform_dashboard_metrics do |t|
      t.datetime :capture_time
      t.string :metric_name
      t.string :metric_value
      t.string :metric_description
      t.string :component_name
      t.string :component_type
      t.string :metric_status
      t.string :remarks
      t.belongs_to :server, foreign_key: true

      t.timestamps
    end
  end
end
