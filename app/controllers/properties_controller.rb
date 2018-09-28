class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_property, only: [:edit, :update, :destroy]

  def index
    @properties = current_user.properties.includes(:images)
  end

  def show
    @property = Property.friendly.find(params[:id])
    @property.update visits_count: @property.visits_count + 1
    render layout: false
  end

  def increase_shares_count
    @property = Property.friendly.find(params[:id])
    if current_user != @property.user
      @property.update shares_count: @property.shares_count + 1
    end
    head :ok
  end

  def new
    @property = current_user.properties.new
  end

  def edit
  end

  def create
    @property = current_user.properties.new(property_params)
    @property.user = current_user

    respond_to do |format|
      if @property.save
        format.html { redirect_to edit_property_path(@property), notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to edit_property_path(@property), notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_property
      @property = current_user.properties.friendly.find(params[:id])
    end

    def property_params
      params.require(:property).permit(
        :name,
        :slug,
        :logo,
        :description,
        :address,
        :address2,
        :country,
        :price,
        :beds,
        :bath,
        :is_rent,
        :parking,
        :agent_id,
        property_images: [:file],
      )
    end
end
