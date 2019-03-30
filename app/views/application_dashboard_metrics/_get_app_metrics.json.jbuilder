#json.service_status Service.joins(applications: :application_dashboard_metrics).group(:id,:application_id,:metric_name,:metric_description).order('capture_time DESC').pluck('service_id, application_id, metric_name, metric_value, metric_status,metric_description ').map { |p| {service_id: p[0], application_id:p[1], metric_name:p[2], metric_value: p[3], metric_status: p[4],metric_description: p[5]}}

json.service_status ApplicationDashboardMetric.joins(application: :service).group(:application_id,:metric_name).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("capture_time DESC").pluck('service_id, application_id,MAX(capture_time),metric_name,metric_description,metric_value,metric_status').map { |p| {service_id: p[0], application_id:p[1], capture_time:p[2],metric_name:p[3], metric_description:p[4],metric_value: p[5], metric_status: p[6]}}

