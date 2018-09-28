class ProfilePagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile_page, only: [:show, :edit, :update, :destroy]

  # GET /profile_pages
  # GET /profile_pages.json
  def index
    @profile_pages = ProfilePage.all
  end

  # GET /profile_pages/1
  # GET /profile_pages/1.json
  def show
    @posts = @profile_page.posts.includes(:profiles, :pages)
    @posts = @posts.where("date(scheduled_at) = ?", Date.parse(params[:date]).to_time.utc.to_date) if params[:date]
    render 'posts/index'
  end

  # GET /profile_pages/new
  def new
    @profile_page = ProfilePage.new
  end

  # GET /profile_pages/1/edit
  def edit
  end

  # POST /profile_pages
  # POST /profile_pages.json
  def create
    @profile_page = ProfilePage.new(profile_page_params)

    respond_to do |format|
      if @profile_page.save
        format.html { redirect_to @profile_page, notice: 'Profile page was successfully created.' }
        format.json { render :show, status: :created, location: @profile_page }
      else
        format.html { render :new }
        format.json { render json: @profile_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_pages/1
  # PATCH/PUT /profile_pages/1.json
  def update
    respond_to do |format|
      if @profile_page.update(profile_page_params)
        format.html { redirect_to @profile_page, notice: 'Profile page was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_page }
      else
        format.html { render :edit }
        format.json { render json: @profile_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_pages/1
  # DELETE /profile_pages/1.json
  def destroy
    @profile_page.destroy
    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Profile page was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_page
      @profile_page = ProfilePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_page_params
      params.fetch(:profile_page, {})
    end
end
