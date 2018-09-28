class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:new]

  # GET /profiles
  # GET /profiles.json
  def index

    @profiles = current_user.profiles.includes(:user).order(id: :desc)
    @pages = current_user.profile_pages.where(connect: 1, page_type: '').includes(:user).order(id: :desc)
    @idea = current_user.ideas.where(id: params[:idea_id]).first
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @posts = @profile.posts.includes(:profiles, :pages)
    @posts = @posts.where("date(scheduled_at) = ?", Date.parse(params[:date])) if params[:date]
    render 'posts/index'
  end

  # GET /profiles/new
  def new
    User.where(authentication_token: nil).map(&:save)
    head :ok
  end

  # GET /profiles/1/edit
  def edit
    
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find_by(id: params[:id])
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Profile was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.fetch(:profile, {})
    end
end
