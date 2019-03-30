json.service_name @service.name
json.service_id @service.id
json.applications @service.applications.each do |aplic|
            json.application_name aplic.name
            json.application_id aplic.id
            json.metrics aplic.application_dashboard_metrics.uniq{|p|p.metric_name}.each do |metric|
              json.metric_name metric.metric_name
              json.metric_id metric.id
              json.metric_description metric.description
              json.metric_value metric.metric_value
							json.metric_status metric.gethealthstatus(metric.metric_name)
            end
end
