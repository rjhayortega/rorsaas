class QueuePostsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_queue_post, only: [:show, :edit, :update, :destroy]
  before_action :set_queue_list, only: [:new, :create]  

  def index
    @queue_posts = QueuePost.all
  end

  def show
  end

  def new
    @queue_post = QueuePost.new
  end

  def edit
  end

  def create

    @queue_post = @queue_list.queue_posts.new(queue_post_params)
    
    respond_to do |format|
      if @queue_post.save

        if !@queue_post.image.present? && @queue_post.post_url.present?
    
          #-----scrapping date-------
          page = MetaInspector.new(@queue_post.post_url)

          data_image = page.images.best
          data_title = page.best_title
          data_content = page.best_description
          data_url = page.root_url
          #-----scrapping date end---
          @queue_post.update_column :other_image_url, page.images.best
          @queue_post.posts.update_all other_image_url: page.images.best
        end

        format.html { redirect_to @queue_list, notice: 'Queue post was successfully created.' }
        format.json { render :show, status: :created, location: @queue_post }
      else
        format.html { render :new }
        format.json { render json: @queue_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @queue_post.update(queue_post_params)
        format.html { redirect_to @queue_post.queue_list, notice: 'Queue post was successfully updated.' }
        format.json { render :show, status: :ok, location: @queue_post }
      else
        format.html { render :edit }
        format.json { render json: @queue_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @queue_post.destroy

    respond_to do |format|
      format.html { redirect_to @queue_post.queue_list, notice: 'Queue post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_queue_post
      @queue_post = current_user.queue_posts.find(params[:id])
      @queue_list = @queue_post.queue_list
    end

    def set_queue_list
      @queue_list = current_user.queue_lists.find(params[:queue_list_id])
    end

    def queue_post_params
      params.require(:queue_post).permit(:description, :post_url, :utc_offset, :queue_post, :image, :subimage1, :subimage2, :subimage3, :queue_list_id, :other_image_url)
    end
end
