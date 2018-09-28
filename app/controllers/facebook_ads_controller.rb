class FacebookAdsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facebook_ad, only: [:show, :edit, :update, :destroy]
  before_action :set_facebook_connected_account

  # GET /facebook_ads
  # GET /facebook_ads.json
  def index
    @facebook_ads = FacebookAd.all
  end

  # GET /facebook_ads/1
  # GET /facebook_ads/1.json
  def show
  end

  # GET /facebook_ads/new
  def new
    @facebook_ad = FacebookAd.new
  end

  # GET /facebook_ads/1/edit
  def edit
  end

  # POST /facebook_ads
  # POST /facebook_ads.json
  def create
    @facebook_ad = FacebookAd.new(facebook_ad_params)
    @facebook_ad.facebook_connected_account = @facebook_connected_account

    respond_to do |format|
      if @facebook_ad.save
        format.html { redirect_to @facebook_ad, notice: 'Facebook ad was successfully created.' }
        format.json { render :show, status: :created, location: @facebook_ad }
      else
        format.html { render :new }
        format.json { render json: @facebook_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facebook_ads/1
  # PATCH/PUT /facebook_ads/1.json
  def update
    respond_to do |format|
      if @facebook_ad.update(facebook_ad_params)
        format.html { redirect_to @facebook_ad, notice: 'Facebook ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @facebook_ad }
      else
        format.html { render :edit }
        format.json { render json: @facebook_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facebook_ads/1
  # DELETE /facebook_ads/1.json
  def destroy
    @facebook_ad.destroy
    respond_to do |format|
      format.html { redirect_to facebook_ads_url, notice: 'Facebook ad was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facebook_ad
      @facebook_ad = FacebookAd.find(params[:id])
    end

    def set_facebook_connected_account
      @facebook_connected_account = FacebookConnectedAccount.find(params[:facebook_connected_account_id]) if params[:facebook_connected_account_id].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facebook_ad_params
      params.require(:facebook_ad).permit(
        :campaign_name,
        :objective,
        :audience_location,
        :audience_group,
        :gender_preference,
        :detail,
        :total_budget,
        :start_on,
        :finish_on,
        :url,
        :headline,
        :best_pitch,
        :page_id,
        :image,
      )
    end
end
