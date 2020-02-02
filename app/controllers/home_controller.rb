class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
		#@services = Service.all
  end

  def get_application_status
    respond_to do |format|
            format.html { render "home/_get_application_status", layout: false}
            format.json { render "home/_get_application_status", status: :ok}
    end
  end
	
	def get_services_status
		@services = Service.all
    respond_to do |format|
            format.html { render "home/_get_services_status", layout: false}
            format.json { render "home/_get_services_status", status: :ok}
    end
  end

end
