json.extract! application_dashboard_metric, :id, :capture_time, :metric_name, :metric_description, :metric_value, :component_name, :component_type, :metric_status, :remarks, :application_id, :created_at, :updated_at
json.url application_dashboard_metric_url(application_dashboard_metric, format: :json)
