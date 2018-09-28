class App::ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /app/contents
  # GET /app/contents.json
  def index
    @contents = Content.all
  end

  # GET /app/contents/1
  # GET /app/contents/1.json
  def show
  end

  # GET /app/contents/new
  def new
    @content = Content.new
  end

  # GET /app/contents/1/edit
  def edit
  end

  # POST /app/contents
  # POST /app/contents.json
  def create
    @content = Content.new(content_params)
    @content.user = current_user

    charge = Stripe::Charge.create(
      :amount => 2000,
      :currency => "usd",
      :source => params[:stripeToken],
      :description => "Charge for jayden.smith@example.com"
    )

    @content.charge_id = charge.id

    respond_to do |format|
      if @content.save
        format.html { redirect_to app_content_path(@content), notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app/contents/1
  # PATCH/PUT /app/contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app/contents/1
  # DELETE /app/contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to app_contents_url, notice: 'Content was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:description)
    end
end
