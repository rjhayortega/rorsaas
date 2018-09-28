class PostTasksController < ApplicationController
  before_action :set_post_task, only: [:show, :edit, :update, :destroy]

  # GET /post_tasks
  # GET /post_tasks.json
  def index
    @post_tasks = PostTask.all
  end

  # GET /post_tasks/1
  # GET /post_tasks/1.json
  def show
  end

  # GET /post_tasks/new
  def new
    @post_task = PostTask.new
  end

  # GET /post_tasks/1/edit
  def edit
  end

  # POST /post_tasks
  # POST /post_tasks.json
  def create
    @post_task = PostTask.new(post_task_params)

    respond_to do |format|
      if @post_task.save
        format.html { redirect_to @post_task, notice: 'Post task was successfully created.' }
        format.json { render :show, status: :created, location: @post_task }
      else
        format.html { render :new }
        format.json { render json: @post_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_tasks/1
  # PATCH/PUT /post_tasks/1.json
  def update
    respond_to do |format|
      if @post_task.update(post_task_params)
        format.html { redirect_to @post_task, notice: 'Post task was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_task }
      else
        format.html { render :edit }
        format.json { render json: @post_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_tasks/1
  # DELETE /post_tasks/1.json
  def destroy
    @post_task.destroy
    respond_to do |format|
      format.html { redirect_to post_tasks_url, notice: 'Post task was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_task
      @post_task = PostTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_task_params
      params.require(:post_task).permit(:post_id, :profilable_id, :profilable_type)
    end
end
