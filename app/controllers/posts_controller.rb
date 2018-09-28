class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def draft
    current_user.posts.map(&:migrate_from_old) if params[:token]

    @posts = current_user
      .posts
      .draft
      .includes(:profiles, :pages)
      .where("scheduled_at > ?", 2.months.ago)
      .order(:scheduled_at)

    if params[:date]
      timezone = current_user.timezone || 'utc'
      date = Date.parse(params[:date])
      @posts = @posts.where(scheduled_at: (date.midnight..date.end_of_day))
    end
  end

  def index
    current_user.posts.map(&:migrate_from_old) if params[:token]
    @posts = current_user
      .posts
      .includes(:profiles, :pages)
      .where("scheduled_at > ?", 2.months.ago)
      .order(:scheduled_at)

    if params[:date]
      timezone = current_user.timezone || 'utc'
      date = Date.parse(params[:date])
      @posts = @posts.where(scheduled_at: (date.midnight..date.end_of_day))
    end

  end

  def shorten
    render plain: Bitly.client.shorten(params[:url]).short_url
  end

  def preview

    page = MetaInspector.new(params[:url]) if params[:url].present?

    data_image = page.images.best
    data_title = page.best_title
    data_content = page.best_description
    data_url = page.root_url
    data = { image: data_image, title: data_title, content: data_content, url: data_url }

    render plain: data.to_json

  end

  def show
  end

  def new
    @init_scheduled_at = params[:scheduled_at]
    @post = Post.new(
      queue_list_id: params[:queue_list_id],
      status_draft_post: params[:status_draft_post],
    )
    if params[:queue_list_id]
      @queue_list = current_user.queue_lists.find params[:queue_list_id]
    end

  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    @post.fill_garbage
    # @post.fill_user_utc_offset

    @queue_list = current_user.queue_lists.find(post_params[:queue_list_id]) if post_params[:queue_list_id].present?
    @post.queue_list = @queue_list.presence

    respond_to do |format|
      if @post.save

        if !@post.image.present? && @post.post_url.present?
    
          #-----scrapping date-------
          page = MetaInspector.new(@post.post_url)

          data_image = page.images.best
          data_title = page.best_title
          data_content = page.best_description
          data_url = page.root_url
          #-----scrapping date end---
          @post.update_column :other_image_url, page.images.best
        end
        
        if @post
          @post.deploy! unless @post.is_draft?

          format.html {
            if @post.queue_list.present?
              redirect_to queue_list_posts_path(@post.queue_list)
            elsif @post.is_draft?
              redirect_to promotions_path
            else
              redirect_to posts_path
            end
          }
          format.json { render :show, status: :created, location: @post }
        else
          flash[:error] = "Please choose at least one account"
          format.html { redirect_back fallback_location: new_post_path }
        end
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end


  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @post.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: posts_url }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      if current_user&.is_web_admin?
        @post = Post.find(params[:id])
      else
        @post = current_user.posts.find(params[:id])
      end
    end

    def post_params
      params.require(:post).permit(
        :image,
        :subimage1,
        :subimage2,
        :subimage3,
        :queue_list_id,
        :status_draft_post,
        :description,
        :scheduled_at,
        :timezone_str,
        :post_type,
        :utc_offset,
        :utc_offset,
        :is_draft,
        :post_url,
        profile_ids: [],
        page_ids: [],


      )
    end
end
