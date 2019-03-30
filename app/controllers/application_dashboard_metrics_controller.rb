class ApplicationDashboardMetricsController < ApplicationController
  before_action :set_application_dashboard_metric, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

  # GET /application_dashboard_metrics
  # GET /application_dashboard_metrics.json
  def index
		@application_dashboard_metrics = ApplicationDashboardMetric.all.order('capture_time desc')

		if params[:metric_name] && params[:appid]
			@application_dashboard_metrics = ApplicationDashboardMetric.where("application_id = ? and metric_name = ?", params[:appid], params[:metric_name]).order('capture_time desc , metric_name desc')
		end

		if params[:metric_name].blank? && params[:appid]
			#@application_dashboard_metrics = ApplicationDashboardMetric.where("application_id = ?" , params[:appid]).order('capture_time desc ,metric_name desc')
			@application_dashboard_metrics = ApplicationDashboardMetric.joins(application: :service).group(:id,:application_id,:metric_name,:metric_description).where('application_id = ? and (capture_time <= ? and capture_time > ?)',params[:appid] , Time.now, 1.hour.ago).order("capture_time desc , metric_name desc")
		end
		
    #@application_dashboard_metrics = params[:metric_name]? ApplicationDashboardMetric.where("application_id = ? and metric_name = ?", params[:appid], params[:metric_name]):ApplicationDashboardMetric.all
  end

  # GET /application_dashboard_metrics/1
  # GET /application_dashboard_metrics/1.json
  def show
  end

  # GET /application_dashboard_metrics/new
  def new
    @application_dashboard_metric = ApplicationDashboardMetric.new
  end

  # GET /application_dashboard_metrics/1/edit
  def edit
  end

  # POST /application_dashboard_metrics
  # POST /application_dashboard_metrics.json
  def create
    @application_dashboard_metric = ApplicationDashboardMetric.new(application_dashboard_metric_params)

    respond_to do |format|
      if @application_dashboard_metric.save
        format.html { redirect_to @application_dashboard_metric, notice: 'Application dashboard metric was successfully created.' }
        format.json { render :show, status: :created, location: @application_dashboard_metric }
      else
        format.html { render :new }
        format.json { render json: @application_dashboard_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_dashboard_metrics/1
  # PATCH/PUT /application_dashboard_metrics/1.json
  def update
    respond_to do |format|
      if @application_dashboard_metric.update(application_dashboard_metric_params)
        format.html { redirect_to @application_dashboard_metric, notice: 'Application dashboard metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @application_dashboard_metric }
      else
        format.html { render :edit }
        format.json { render json: @application_dashboard_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_dashboard_metrics/1
  # DELETE /application_dashboard_metrics/1.json
  def destroy
    @application_dashboard_metric.destroy
    respond_to do |format|
      format.html { redirect_to application_dashboard_metrics_url, notice: 'Application dashboard metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


	def get_app_metrics
    respond_to do |format|
						format.html { render "application_dashboard_metrics/_get_app_metrics", layout: false}
						format.json { render "application_dashboard_metrics/_get_app_metrics", status: :ok, location: @application_dashboard_metric }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_dashboard_metric
      @application_dashboard_metric = ApplicationDashboardMetric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_dashboard_metric_params
      params.require(:application_dashboard_metric).permit(:capture_time, :metric_name,:metric_description,:metric_value, :component_name, :component_type, :metric_status, :remarks, :application_id)
    end
end
