class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = current_user.profiles
    # @pages = current_user.profile_pages
    @pages = current_user.profile_pages.where(connect: 1, page_type: '').includes(:user).order(id: :desc)
    
    @is_connect = 0
    @pages.each do |page|
      if page.connect == 0 && page.network == 'facebook'
        @is_connect += 1
      end
    end
  end

  def show
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def choose_fb_pages
    @update_profile = ProfilePage.where(page_id: params[:pageIds]).update_all(connect: 1)
    respond_to do |format|
      format.json { render json: @update_profile }
    end
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.fetch(:account, {})
    end
end
