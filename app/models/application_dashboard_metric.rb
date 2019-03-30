class ApplicationDashboardMetric < ApplicationRecord
  belongs_to :application

  def isFailed(metric_name=nil,metric_description=nil)
    p metric_name
		ApplicationDashboardMetric.where(metric_name:metric_name,metric_description:metric_description).order("capture_time DESC").first.metric_status == "KO"
  end

  def gethealthstatus(metric_name=nil,metric_description=nil)
    p "ApplicationDashboardMetric---gethealthstatus---#{metric_name}"
		ApplicationDashboardMetric.where(metric_name:metric_name,metric_description:metric_description).order("capture_time DESC").first.metric_status
  end

end
