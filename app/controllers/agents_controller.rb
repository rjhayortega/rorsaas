class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  def index
    @agents = current_user.agents.all
  end

  def show
  end

  def new
    @agent = current_user.agents.new
  end

  def edit
  end

  def create
    @agent = current_user.agents.new(agent_params)
    @agent.user = current_user

    respond_to do |format|
      if @agent.save
        format.html { redirect_to agents_path, notice: 'Agent was successfully created.' }
        format.json { render :show, status: :created, location: @agent }
      else
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_agent
      @agent = current_user.agents.find(params[:id])
    end

    def agent_params
      params.require(:agent).permit(:photo, :first_name, :last_name, :email, :phone)
    end
end
