class Service < ApplicationRecord
	has_many :applications

  def isAnyApplicationFailed(service=nil)
    p service.name
    result=true
		service.applications.each do |aplic|
						aplic.application_dashboard_metrics.uniq{|p|p.metric_name}.each do |metric|
							result=metric.isFailed(metric.metric_name)
							break if result==true
						end
						break if result==true
		end

    return result
  end

  def gethealthstatus(service=nil)
		p service.name
    result=true
		service.applications.each do |aplic|
            aplic.application_dashboard_metrics.uniq{|p|[p.metric_name,p.metric_description]}.each do |metric|
							result=metric.gethealthstatus(metric.metric_name,metric.metric_description)
              break if result==true
            end
            break if result==true
    end

    return result

	end

	def self.get_service_healthstatus()

			###################################################
			# This is the SQL query thats run on the following ruby code:
			#
			# SELECT "application_dashboard_metrics".* FROM "application_dashboard_metrics" INNER JOIN "applications" ON "applications"."id" = "application_dashboard_metrics"."application_id" INNER JOIN "services" ON "services"."id" = "applications"."service_id" WHERE (capture_time <= '2019-03-24 10:33:51.922715' and capture_time > '2019-03-24 05:33:51.922768') GROUP BY "application_dashboard_metrics"."application_id", "application_dashboard_metrics"."metric_name" ORDER BY MAX(capture_time) DESC
			# ApplicationDashboardMetric.joins(application: :service).group(:application_id,:metric_name).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("MAX(capture_time) DESC")
			
			# this is the old query with select MAX in pluck
			#ApplicationDashboardMetric.joins(application: :service).group(:application_id,:metric_name).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("capture_time DESC").pluck('service_id, application_id,MAX(capture_time),metric_name,metric_description,metric_value,metric_status').map { |p| {service_id: p[0], application_id:p[1], capture_time:p[2],metric_name:p[3], metric_description:p[4],metric_value: p[5], metric_status: p[6]}}
			#PlatformDashboardMetric.joins(server: :application).group(:id,:application_id,:metric_name,:metric_description).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("capture_time DESC").pluck('service_id, application_id, server_id ,capture_time,metric_name,metric_description,metric_value,metric_status').map { |p| {service_id: p[0], application_id:p[1], server_id:p[2], capture_time:p[3],metric_name:p[4], metric_description:p[5],metric_value: p[6], metric_status: p[7]}}
			###################################################

			app_metric = ApplicationDashboardMetric.joins(application: :service).group(:application_id,:metric_name).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("MAX(capture_time) DESC")

			platform_metrics = PlatformDashboardMetric.joins(server: :application).group(:id,:application_id,:metric_name,:metric_description).where('capture_time <= ? and capture_time > ?', Time.now, 1.hour.ago).order("MAX(capture_time) DESC")


			#  ApplicationDashboardMetric Load (0.3ms)  SELECT "application_dashboard_metrics".* FROM "application_dashboard_metrics" INNER JOIN "applications" ON "applications"."id" = "application_dashboard_metrics"."application_id" INNER JOIN "services" ON "services"."id" = "applications"."service_id" WHERE (capture_time <= '2019-03-24 10:47:31.734948' and capture_time > '2019-03-24 05:47:31.734966') GROUP BY "application_dashboard_metrics"."application_id", "application_dashboard_metrics"."metric_name" ORDER BY MAX(capture_time) DESC

		#<ApplicationDashboardMetric id: 3, capture_time: "2019-03-24 10:30:00", metric_name: "css.app.process.cssprovisioning", metric_value: "", metric_description: "CSS Provisioning", component_name: "CSS", component_type: "Application", metric_status: "KO", remarks: "Application Process is not running", application_id: 1, created_at: "2019-03-20 17:22:05", updated_at: "2019-03-24 10:33:16">
		#<ApplicationDashboardMetric id: 2, capture_time: "2019-03-24 10:21:00", metric_name: "css.app.process.ernieprovisioining", metric_value: "", metric_description: "Ernie Provisioning", component_name: "CSS", component_type: "Application", metric_status: "OK", remarks: "", application_id: 1, created_at: "2019-03-20 17:22:05", updated_at: "2019-03-24 10:27:35">
		#<ApplicationDashboardMetric id: 4, capture_time: "2019-03-24 10:10:00", metric_name: "css.app.requests.pending", metric_value: "1/711", metric_description: "CSS Provisioning pending requests (Menu P count)", component_name: "CSS", component_type: "Application", metric_status: "KO", remarks: "Application Process is not running", application_id: 1, created_at: "2019-03-20 17:22:05", updated_at: "2019-03-24 10:10:44">
	
		#	PlatformDashboardMetric Load (0.2ms)  SELECT "platform_dashboard_metrics".* FROM "platform_dashboard_metrics" INNER JOIN "servers" ON "servers"."id" = "platform_dashboard_metrics"."server_id" INNER JOIN "applications" ON "applications"."id" = "servers"."application_id" WHERE (capture_time <= '2019-03-24 10:47:31.736993' and capture_time > '2019-03-24 05:47:31.737015') GROUP BY "platform_dashboard_metrics"."id", "application_id", "platform_dashboard_metrics"."metric_name", "platform_dashboard_metrics"."metric_description" ORDER BY MAX(capture_time) DESC
#<PlatformDashboardMetric id: 1, capture_time: "2019-03-24 09:45:00", metric_name: "css.platform.cpu", metric_value: "42.5", metric_description: "CPU load", component_name: "CSS", component_type: "Platform", metric_status: "KO", remarks: "CPU load is not ok", server_id: 1, created_at: "2019-03-23 23:16:39", updated_at: "2019-03-24 10:16:21">

			service_status = Hash.new("OK")
			app_status = Hash.new()
			result = Hash.new()

			app_metric.each do |a|
				p "#{a.application.service.id}, #{a.metric_status}"
				service_status[a.application.service.id] = a.metric_status
				app_status[a.application.id] = a.metric_status
			end 
	
			pp "-------"
			pp service_status
			pp app_status

			platform_metrics.each do |p|
				p "#{p.server.application.service.id}, #{p.metric_status}"
	
				app_id = p.server.application.id
				service_id = p.server.application.service.id
				metric_status = p.metric_status

				if(service_status.include?(service_id) && metric_status != "KO")
					service_status[service_id] = metric_status
				else
					service_status[service_id] = metric_status
				end
				
				if(app_status.include?(app_id) && metric_status != "KO")
					app_status[app_id] = metric_status
				else
					app_status[app_id] = metric_status
				end

			end
		
			pp service_status
			pp app_status
			
			result = {"service_status" => service_status.map{ |p| {service_id:p[0],metric_status: p[1]}},
								"app_status" =>  app_status.map{ |a| {application_id:a[0],metric_status: a[1]}} }

			#platform  .pluck('service_id, application_id, server_id ,capture_time,metric_name,metric_description,metric_value,metric_status').map { |p| {service_id: p[0], application_id:p[1], server_id:p[2], capture_time:p[3],metric_name:p[4], metric_description:p[5],metric_value: p[6], metric_status: p[7]}}

			#application .map { |p| {service_id: p[0], application_id:p[1], capture_time:p[2],metric_name:p[3], metric_description:p[4],metric_value: p[5], metric_status: p[6]}}
	end

end
