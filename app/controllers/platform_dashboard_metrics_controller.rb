class PlatformDashboardMetricsController < ApplicationController
  before_action :set_platform_dashboard_metric, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /platform_dashboard_metrics
  # GET /platform_dashboard_metrics.json
  def index
    @platform_dashboard_metrics = PlatformDashboardMetric.all.order('capture_time desc')

    if params[:metric_name] && params[:appid]
      @platform_dashboard_metrics = PlatformDashboardMetric.where("application_id = ? and metric_name = ?", params[:appid], params[:metric_name]).order('capture_time desc , metric_name desc')
    end

    if params[:metric_name].blank? && params[:appid]
      @platform_dashboard_metrics = PlatformDashboardMetric.joins(server: :application).group(:id,:application_id,:metric_name,:metric_description).where('application_id = ? and (capture_time <= ? and capture_time > ?)',params[:appid] , Time.now, DateTime.now.beginning_of_day).order("capture_time desc , metric_name desc")
    end

  end


  # GET /platform_dashboard_metrics/1
  # GET /platform_dashboard_metrics/1.json
  def show
  end

  # GET /platform_dashboard_metrics/new
  def new
    @platform_dashboard_metric = PlatformDashboardMetric.new
  end

  # GET /platform_dashboard_metrics/1/edit
  def edit
  end

  # POST /platform_dashboard_metrics
  # POST /platform_dashboard_metrics.json
  def create
    @platform_dashboard_metric = PlatformDashboardMetric.new(platform_dashboard_metric_params)

    respond_to do |format|
      if @platform_dashboard_metric.save
        format.html { redirect_to @platform_dashboard_metric, notice: 'Platform dashboard metric was successfully created.' }
        format.json { render :show, status: :created, location: @platform_dashboard_metric }
      else
        format.html { render :new }
        format.json { render json: @platform_dashboard_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /platform_dashboard_metrics/1
  # PATCH/PUT /platform_dashboard_metrics/1.json
  def update
    respond_to do |format|
      if @platform_dashboard_metric.update(platform_dashboard_metric_params)
        format.html { redirect_to @platform_dashboard_metric, notice: 'Platform dashboard metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @platform_dashboard_metric }
      else
        format.html { render :edit }
        format.json { render json: @platform_dashboard_metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /platform_dashboard_metrics/1
  # DELETE /platform_dashboard_metrics/1.json
  def destroy
    @platform_dashboard_metric.destroy
    respond_to do |format|
      format.html { redirect_to platform_dashboard_metrics_url, notice: 'Platform dashboard metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_platform_metrics
    respond_to do |format|
            format.html { render "platform_dashboard_metrics/_get_platform_metrics", layout: false}
            format.json { render "platform_dashboard_metrics/_get_platform_metrics", status: :ok, location: @platform_dashboard_metric }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform_dashboard_metric
      @platform_dashboard_metric = PlatformDashboardMetric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_dashboard_metric_params
      params.require(:platform_dashboard_metric).permit(:capture_time, :metric_name, :metric_value, :metric_description, :component_name, :component_type, :metric_status, :remarks, :server_id)
    end
end
