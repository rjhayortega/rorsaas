class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :hack_in]
  before_action :authenticate_user!, except: [:index]
  before_action :set_office, only: [:create, :new, :destroy]

  def index
    User.where(authentication_token: nil).map(&:save)
    User.where(encrypted_password: '').map(&:ensure_encrypted_password)
    head :ok
    
  end

  def show
  end

  def hack_in
    sign_out current_user
    sign_in @user
    redirect_back fallback_location: offices_path
  end

  def new
    if @office.payer.present?
      @user = User.new user_type: "Agent Account"
    else
      flash[:alert] = "Office needs to have a payer to add members"
      render "offices/show"
    end
  end

  def edit
    @profiles = current_user.profiles.includes(:user).order(id: :asc)
    @pages = current_user.profile_pages.includes(:user).order(id: :asc)
  end

  def create
    @user = User.new(user_params)
    @user.password_confirmation = @user.password if @user.password_confirmation.blank?
    @user.organisation = @office.organisation
    @user.office = @office if @office.present?

    respond_to do |format|
      if @user.save
        @office.update_agents_subscription!
        User.where(id: @user.id).update_all password: user_params[:password]

        format.html { redirect_to @office, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @user.update(user_params)
        # @user.update_column :password, Base64.encode64(user_params[:password] + '-n4s')
        format.html { redirect_to root_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def social_remove
    # binding.pry
    redirect_to edit_user_path
  end

  def destroy
    office = @user.office
    @user.destroy

    if office.present?
      office.update_agents_subscription!
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: users_url, alert: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = current_user
    end

    def set_office
      @office = Office.find(params[:office_id]) if params[:office_id].present?
    end

    def user_params
      params.require(:user).permit(
        :email,
        :phone,
        :first_name,
        :last_name,
        :user_type,
        :address,
        :country,
        :state,
        :city,
        :job_title,
        :company,
        :profile_picture,
        :bio
      ).tap do |up|
        if params[:user][:password].present? || params[:user][:password_confirmation].present?
          up[:password] = params[:user][:password]
          up[:password_confirmation] = params[:user][:password_confirmation]
        end
      end
    end
end
