class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /reports
  # GET /reports.json
  def index
    if params[:start_on].present? || params[:end_on].present?
      @start_on = Date.parse(params[:start_on])
      @end_on = Date.parse(params[:end_on])
    else
      @start_on = 1.months.ago
      @end_on = Date.today
    end

    @graph = FacebookService.crop_smart_client
    @fb_campaigns = @graph.get_connections('act_348667488829138', "campaigns",
      effective_status: "['ACTIVE']",
      is_completed: false,
    )

    @fb_time_range = {
      since: @start_on.strftime("%Y-%m-%d"),
      until: @end_on.strftime("%Y-%m-%d"),
    }.to_json

    @campaigns = MailchimpService.campaigns(
      since_send_time: @start_on.to_time.iso8601,
      before_send_time: @end_on.to_time.iso8601
    )
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:index)
    end
end
