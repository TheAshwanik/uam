class PlatformDashboardMetric < ApplicationRecord
  belongs_to :server
 
	def gethealthstatus(metric_name=nil,metric_description=nil)
    p "PlatformDashboardMetric---gethealthstatus---#{metric_name}"
    PlatformDashboardMetric.where(metric_name:metric_name,metric_description:metric_description).order("capture_time DESC").first.metric_status
  end

end
