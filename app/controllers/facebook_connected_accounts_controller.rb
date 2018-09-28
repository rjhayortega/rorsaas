class FacebookConnectedAccountsController < ApplicationController
  before_action :set_facebook_connected_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @facebook_connected_accounts = current_user.facebook_connected_accounts.all
    @facebook_ads = current_user.facebook_ads
  end

  def show
  end

  def new
    @facebook_connected_account = FacebookConnectedAccount.new
  end

  def edit
  end

  def create
    @facebook_connected_account = FacebookConnectedAccount.new(facebook_connected_account_params)
    @facebook_connected_account.user = current_user

    respond_to do |format|
      if @facebook_connected_account.save
        format.html { redirect_to facebook_connected_accounts_path, notice: 'Facebook connected account was successfully created.' }
        format.json { render :show, status: :created, location: @facebook_connected_account }
      else
        format.html { render :new }
        format.json { render json: @facebook_connected_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @facebook_connected_account.update(facebook_connected_account_params)
        format.html { redirect_to @facebook_connected_account, notice: 'Facebook connected account was successfully updated.' }
        format.json { render :show, status: :ok, location: @facebook_connected_account }
      else
        format.html { render :edit }
        format.json { render json: @facebook_connected_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facebook_connected_account.destroy
    respond_to do |format|
      format.html { redirect_to facebook_connected_accounts_url, notice: 'Facebook connected account was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_facebook_connected_account
      @facebook_connected_account = FacebookConnectedAccount.find(params[:id])
    end

    def facebook_connected_account_params
      params.require(:facebook_connected_account).permit(:profile_page_id)
    end
end
