class QueueListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_queue_list, only: [:show, :edit, :update, :destroy, :activity, :accounts, :calendar, :reschedule, :scrap_image]

  def index
    @queue_lists = current_user.queue_lists.all
    @promotion_posts = current_user.promotion_posts.active
  end

  def show
  end

  def reschedule
    @queue_list.spread_posts
    redirect_back fallback_location: @queue_list
  end

  def calendar
    @posts = @queue_list.posts.order(:scheduled_at)
    @posts = @posts.where("date(scheduled_at) = ?", params[:date]) if params[:date]
    render 'posts/index'
  end


  def new
    @queue_list = QueueList.new
  end

  def edit
  end

  def activity
    @queue_list.started_on ||= Date.today
  end

  def accounts
    @profiles = current_user.profiles
    @pages = current_user.profile_pages
  end

  def create
    @queue_list = QueueList.new(queue_list_params)
    @queue_list.user = current_user
    @queue_list.activity ||= 1
    @queue_list.image ||= ''
    @queue_list.started_on ||= Date.current

    respond_to do |format|
      if @queue_list.save
        format.html { redirect_to activity_queue_list_path(@queue_list, creating: true), notice: 'Queue list was successfully created.' }
        format.json { render :show, status: :created, location: @queue_list }
      else
        format.html { render :new }
        format.json { render json: @queue_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @queue_list.update(queue_list_params)
        format.html {
          if queue_list_params[:activity].present? && params[:creating].present?
            redirect_to accounts_queue_list_path(@queue_list, creating: true)
          else
            redirect_to @queue_list
          end
        }
        format.json { render :show, status: :ok, location: @queue_list }
      else
        format.html { render :edit }
        format.json { render json: @queue_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @queue_list.destroy
    respond_to do |format|
      format.html { redirect_to queue_lists_url, notice: 'Queue list was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_queue_list
      @queue_list = current_user.queue_lists.find(params[:id])
    end

    def queue_list_params
      params.require(:queue_list).permit(
        :name, :cat_name, :activity, :image, :img, :started_on, :ended_on,
        :user_id,
        profile_ids: [],
        profile_page_ids: [],
      )
    end
end
