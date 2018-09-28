class TaskSchedulerJob < ApplicationJob
  def perform
    Post.where('schedule_date > ?', 10.days.ago).where(scheduled_at: nil).map(&:migrate_from_old)
    Post.where(deployed: nil, status: 0).update_all deployed: true
    Post.where(deployed: nil, status: 1).update_all deployed: false

    Post.where(
      scheduled_at: (1.hour.ago..1.hour.from_now),
      deployed: false,
      status_draft_post: 0,
    ).each do |post|
      post.deploy!
    end
  end

end
