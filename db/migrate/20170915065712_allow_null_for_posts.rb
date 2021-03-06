class AllowNullForPosts < ActiveRecord::Migration[5.1]
  def change
    change_column_null :knack_post, :title, true
    change_column_null :knack_post, :linkedin_title, true
    change_column_null :knack_post, :description, true
    change_column_null :knack_post, :fb_text_des, true
    change_column_null :knack_post, :twit_text_des, true
    change_column_null :knack_post, :lin_text_des, true
    change_column_null :knack_post, :pin_text_des, true
    change_column_null :knack_post, :gp_text_des, true
    change_column_null :knack_post, :fb_description, true
    change_column_null :knack_post, :twitter_description, true
    change_column_null :knack_post, :link_description, true
    change_column_null :knack_post, :pin_description, true
    change_column_null :knack_post, :linkedin_description, true
    change_column_null :knack_post, :post_url, true
    change_column_null :knack_post, :linkedin_url, true
    change_column_null :knack_post, :post_img, true
    change_column_null :knack_post, :album_images, true
    change_column_null :knack_post, :post_album, true
    change_column_null :knack_post, :linkedin_image, true
    change_column_null :knack_post, :post_type, true
    change_column_null :knack_post, :facebook, true
    change_column_null :knack_post, :fb_status, true
    change_column_null :knack_post, :fb_pages, true
    change_column_null :knack_post, :fbpg_status, true
    change_column_null :knack_post, :fb_groups, true
    change_column_null :knack_post, :fb_group_status, true
    change_column_null :knack_post, :twitter, true
    change_column_null :knack_post, :twitter_status, true
    change_column_null :knack_post, :google_plus, true
    change_column_null :knack_post, :gplus_status, true
    change_column_null :knack_post, :pinterest, true
    change_column_null :knack_post, :pinterest_status, true
    change_column_null :knack_post, :pin_mail, true
    change_column_null :knack_post, :linkedin, true
    change_column_null :knack_post, :lin_status, true
    change_column_null :knack_post, :lin_pages, true
    change_column_null :knack_post, :linpg_status, true
    change_column_null :knack_post, :user_id, true
    change_column_null :knack_post, :schedule_date, true
    change_column_null :knack_post, :post_date, true
    change_column_null :knack_post, :origninal_scheduled_date, true
    change_column_null :knack_post, :post_time, true
    change_column_null :knack_post, :status, true
    change_column_null :knack_post, :status_draft_post, true
    change_column_null :knack_post, :post_date_report, true
    change_column_null :knack_post, :am_pm, true
    change_column_null :knack_post, :team_member_id, true
    change_column_null :knack_post, :is_approved, true
    change_column_null :knack_post, :reason, true
    change_column_null :knack_post, :sentto, true
    change_column_null :knack_post, :category_name, true
    change_column_null :knack_post, :category_bg, true
    change_column_null :knack_post, :instagram, true
    change_column_null :knack_post, :instagram_status, true
    change_column_null :knack_post, :instagram_description, true
    change_column_null :knack_post, :sched_id, true
    change_column_null :knack_post, :portfolio_id, true
    change_column_null :knack_post, :houseq, true
    change_column_null :knack_post, :catid, true
    change_column_null :knack_post, :ins_text_des, true
    change_column_null :knack_post, :queue_list_id, true
    change_column_null :knack_post, :scheduled_at, true
    change_column_null :knack_post, :utc_offset, true
    change_column_null :knack_post, :created_at, true
    change_column_null :knack_post, :image, true
    change_column_null :knack_post, :subimage1, true
    change_column_null :knack_post, :subimage2, true
    change_column_null :knack_post, :subimage3, true
    change_column_null :knack_post, :queue_post_id, true
    change_column_null :knack_post, :updated_at, true
    change_column_null :knack_post, :deployed, true
    change_column_null :knack_post, :post_tasks_count, true
  end
end
