class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy, :take_payment, :stop_payment]
  before_action :authenticate_user!
  before_action :ensure_organisation

  def index
    if current_user.is_organisation_admin?
      @offices = current_user.offices
      @office = Office.new
    elsif current_user.is_office_admin?
      redirect_to current_user.office
    else
      raise 'Fatal error'
    end
  end

  def stop_payment
    @office.cancel_current_subscriptions!
    redirect_back fallback_location: offices_path
  end

  def take_payment
    customer = Stripe::Customer.create(
      :description => "User ##{current_user.id} with email #{params[:stripeEmail]} for office #{@office.id}",
      :source => params[:stripeToken]
    )
    User.where(id: current_user.id).update_all stripe_customer_id: customer.id

    stripe_manager_subscription = Stripe::Subscription.create(
      :customer => customer.id,
      :items => [
        {
          :plan => "org-manager",
        },
      ],
    )

    stripe_agents_subscription = Stripe::Subscription.create(
      :customer => customer.id,
      :items => [
        {
          :plan => "org-agent",
          :quantity => @office.users_count,
        },
      ],
    )

    @office.cancel_current_subscriptions!
    @office.update(
      stripe_manager_subscription_id: stripe_manager_subscription.id,
      stripe_agents_subscription_id: stripe_agents_subscription.id,
      stripe_customer_id: customer.id,
      payer: current_user,
    )

    redirect_back fallback_location: offices_path
  end

  def show
  end

  def new
    @office = Office.new
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    @office.organisation = current_user.organisation

    respond_to do |format|
      if @office.save
        format.html { redirect_to offices_path }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, notice: 'Office was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_office
      @office = Office.find(params[:id])
    end

    def office_params
      params.require(:office).permit(:name, :organisation_id, :maximum_users_count)
    end
end
