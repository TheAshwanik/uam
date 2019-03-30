json.extract! platform_dashboard_metric, :id, :capture_time, :metric_name, :metric_value, :metric_description, :component_name, :component_type, :metric_status, :remarks, :server_id, :created_at, :updated_at
json.url platform_dashboard_metric_url(platform_dashboard_metric, format: :json)
