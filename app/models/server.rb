class Server < ApplicationRecord
				belongs_to :application
				has_many :platform_dashboard_metrics

				def isAnyMetricFailed(server=nil)
								p aplic.name
								result=true
								server.platform_dashboard_metrics.uniq{|p|[p.metric_name,p.metric_description]}.each do |metric|
											result=metric.gethealthstatus(metric.metric_name,metric.metric_description)
											break if result==true
								end
								return result
				end

end
