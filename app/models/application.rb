class Application < ApplicationRecord
  belongs_to :service
  has_many :servers
  has_many :application_dashboard_metrics

  def isAnyMetricFailed(aplic=nil)
    p aplic.name
		result=true
    aplic.application_dashboard_metrics.uniq{|p|[p.metric_name,p.metric_description]}.each do |metric|
							result=metric.isFailed(metric.metric_name,metric.metric_description)
							break if result==true
		end
		return result
  end


end
