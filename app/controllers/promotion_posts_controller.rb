class PromotionPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_promotion_post, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:deploy, :select_queue, :select_people, :send_to_people, :send_to_queue]

  def select_people
    # @users = User.where(organisation_id: current_user.organisation_id)
    @offices = current_user.offices
  end

  def deploy
    @post.deploy!
  end

  def send_to_people
    offices = current_user.offices.where(id: params[:office_ids]).includes(:users)
    offices.each do |office|
      office.users.each do |user|
        user.promotion_posts.create @post.attributes.except("id").merge(user_id: user.id)
      end
    end

    redirect_to promotion_posts_path, notice: "Posts sent to users"
  end

  def select_queue
    @queues = current_user.queue_lists
  end

  def send_to_queue
    queue_list = current_user.queue_lists.find params[:queue_list_id]
    @queue_post = @post.mirror_queue_post queue_list.id
    redirect_to queue_list
  end

  def index
    @promotion_posts = current_user.created_promotion_posts

    if params[:date]
      timezone = current_user.timezone || 'utc'
      date = Date.parse(params[:date])
      @promotion_posts = @promotion_posts.where(scheduled_at: (date.midnight..date.end_of_day))
    end
  end

  def show
  end

  def new
    @promotion_post = PromotionPost.new
  end

  def edit
  end

  def create
    @promotion_post = PromotionPost.new(promotion_post_params)
    @promotion_post.user = current_user
    @promotion_post.author = current_user

    respond_to do |format|
      if @promotion_post.save
        format.html { redirect_to promotion_posts_path, notice: 'Promotion post was successfully created.' }
        format.json { render :show, status: :created, location: @promotion_post }
      else
        format.html { render :new }
        format.json { render json: @promotion_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @promotion_post.update(promotion_post_params)
        format.html { redirect_to promotion_posts_path, notice: 'Promotion post was successfully updated.' }
        format.json { render :show, status: :ok, location: @promotion_post }
      else
        format.html { render :edit }
        format.json { render json: @promotion_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @promotion_post.destroy
    respond_to do |format|
      format.html { redirect_to promotion_posts_url, notice: 'Promotion post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_promotion_post
      @promotion_post = PromotionPost.find(params[:id])
    end

    def set_post
      @post = PromotionPost.find(params[:id])
    end

    def promotion_post_params
      params.require(:promotion_post).permit(:description,
        :post_url,
        :start_date,
        :end_date,
        :utc_offset, :image, :subimage1, :subimage2, :subimage3)
    end
end
