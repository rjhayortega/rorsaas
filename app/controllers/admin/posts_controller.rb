class Admin::PostsController < ApplicationController
  before_action :authenticate_admin

  def index
    Post.where('schedule_date > ?', 10.days.ago).where(scheduled_at: nil).map(&:migrate_from_old)
    Post.where('scheduled_at > ?', 10.days.ago).where(post_tasks_count: 0).map(&:create_tasks)

    @posts = Post
      .includes(:user, post_tasks: :profilable)
      .where("scheduled_at > ?", 1.hour.ago)
      .order(:scheduled_at)
      .page(params[:page])
  end

  def instagram
    post_ids = PostTask
      .joins(:post)
      .where(profilable_id: Profile.where(network: 'instagram').pluck(:id))
      .where("knack_post.scheduled_at > ?", 1.hour.ago)
      .pluck(:post_id).uniq

    @posts = Post
      .where(id: post_ids)
      .includes(:user, post_tasks: :profilable)
      .order(:scheduled_at)
      .page(params[:page])

    render :index
  end

  def past
    @posts = Post
      .includes(:user, post_tasks: :profilable)
      .where("scheduled_at < ?", Time.current)
      .order(scheduled_at: :desc)
      .page(params[:page])

    render :index
  end
end