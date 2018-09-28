# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180319033428) do

  create_table "ad_order", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "order_id", null: false
    t.string "amount", null: false
    t.string "payment_date", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "plan", null: false
    t.string "transaction_id", limit: 250, null: false
    t.integer "status", null: false
    t.integer "user_id", null: false
  end

  create_table "agents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "photo"
    t.string "first_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "last_name"
    t.index ["user_id"], name: "index_agents_on_user_id"
  end

  create_table "cat_automate", primary_key: "catid", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "cat_name", null: false
    t.integer "activity_settings", null: false
    t.string "img", null: false
    t.string "start_date", limit: 55, null: false
    t.string "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cat_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "catid", null: false
    t.string "profiles_id", limit: 300, null: false
    t.integer "user_id"
  end

  create_table "cat_profiles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "catid", null: false
    t.integer "user_id"
    t.integer "profiles_id"
    t.index ["user_id"], name: "user_id"
    t.index ["user_id"], name: "user_id_2"
    t.index ["user_id"], name: "user_id_3"
  end

  create_table "database_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "enquiries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "postcode"
    t.text "message"
    t.bigint "agent_id"
    t.bigint "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_enquiries_on_agent_id"
    t.index ["property_id"], name: "index_enquiries_on_property_id"
  end

  create_table "facebook_ads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "campaign_name"
    t.string "objective"
    t.string "audience_location"
    t.string "audience_group"
    t.string "gender_preference"
    t.text "detail"
    t.string "total_budget"
    t.date "start_on"
    t.date "finish_on"
    t.string "url"
    t.string "headline"
    t.string "best_pitch"
    t.string "image"
    t.bigint "facebook_connected_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "page_id"
    t.index ["facebook_connected_account_id"], name: "index_facebook_ads_on_facebook_connected_account_id"
    t.index ["page_id"], name: "index_facebook_ads_on_page_id"
  end

  create_table "facebook_connected_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "user_id"
    t.boolean "verified", default: false
    t.bigint "profile_page_id"
    t.string "facebook_ad_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_page_id"], name: "index_facebook_connected_accounts_on_profile_page_id"
    t.index ["user_id"], name: "index_facebook_connected_accounts_on_user_id"
  end

  create_table "hq_ad_audience", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "audience_name", limit: 200, null: false
    t.string "user_id", limit: 20, null: false
    t.datetime "date_saved", null: false
    t.text "ad_location", null: false
    t.string "ad_age_1", limit: 10, null: false
    t.string "ad_age_2", limit: 10, null: false
    t.string "ad_gender", limit: 10, null: false
    t.text "ad_language", null: false
    t.text "ad_detailed", null: false
    t.string "ad_connections", limit: 200, null: false
  end

  create_table "hq_ads_payment", primary_key: "stripe_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "stripe_customer_id", limit: 100, null: false
    t.string "stripe_customer_email", limit: 250, null: false
    t.string "stripe_customer_planid", limit: 250, null: false
    t.string "stripe_customer_plan_amount", limit: 250, null: false
    t.datetime "stripe_customer_created", null: false
    t.integer "stripe_user_id", null: false
    t.string "stripe_customer_name", limit: 250, null: false
    t.string "stripe_subscripe_id", limit: 250, null: false
    t.datetime "stripe_trial_start", null: false
    t.datetime "stripe_trial_ends", null: false
  end

  create_table "hq_feed_house", primary_key: ["agent_id", "unique_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "agent_id", limit: 6, default: "", null: false
    t.string "unique_id", limit: 50, default: "", null: false
    t.text "price"
    t.text "address"
    t.text "headline"
    t.text "description"
  end

  create_table "hq_log_error", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "time", null: false
    t.string "script_name", limit: 100, null: false
    t.string "network", limit: 20, null: false
    t.string "account", limit: 250, null: false
    t.text "message", null: false
  end

  create_table "hq_log_general", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "time", null: false
    t.string "script_name", limit: 100, null: false
    t.string "network", limit: 50, null: false
    t.string "account", limit: 250, null: false
    t.text "message", null: false
  end

  create_table "hq_log_sched", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "time", null: false
    t.string "script_name", limit: 100, null: false
    t.string "network", limit: 20, null: false
    t.string "account", limit: 250, null: false
    t.text "message", null: false
    t.string "user_id", limit: 30, null: false
    t.string "post_type", limit: 20, null: false
  end

  create_table "hq_office_mapping", primary_key: ["office_user", "agent_user"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "office_user", default: 0, null: false
    t.integer "agent_user", default: 0, null: false
    t.index ["agent_user"], name: "agent_user"
  end

  create_table "hq_stripe_subscription", primary_key: "stripe_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "stripe_customer_id", limit: 100, null: false
    t.string "stripe_customer_email", limit: 250, null: false
    t.string "stripe_customer_planid", limit: 250, null: false
    t.string "stripe_customer_plan_amount", limit: 250, null: false
    t.datetime "stripe_customer_created", null: false
    t.integer "stripe_user_id", null: false
    t.string "stripe_customer_name", limit: 250, null: false
    t.string "stripe_subscripe_id", limit: 250, null: false
    t.datetime "stripe_trial_start", null: false
    t.datetime "stripe_trial_ends", null: false
  end

  create_table "hq_timezone", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "gmt", limit: 250, null: false
    t.string "name", limit: 250, null: false
    t.integer "status", null: false
  end

  create_table "hq_user_events", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "user_id", limit: 30, null: false
    t.string "event", limit: 10, null: false
    t.text "message", null: false
    t.datetime "date", null: false
  end

  create_table "hq_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "first_name", limit: 250
    t.string "last_name", limit: 250
    t.string "email", limit: 250
    t.string "user_type", limit: 17
    t.text "note"
    t.string "password", limit: 250
    t.text "address"
    t.string "phone", limit: 250
    t.string "country", limit: 250
    t.string "state", limit: 250
    t.string "city", limit: 250
    t.string "job_title", limit: 250
    t.string "company", limit: 250
    t.string "time_zone", limit: 250
    t.string "business_name", limit: 250
    t.string "assigning_tasks", limit: 250
    t.string "task_notification_emails", limit: 250
    t.string "fb_audience_confirmation", limit: 250
    t.string "fb_photo_upload", limit: 250
    t.string "profile_picture", limit: 250
    t.integer "status", default: 0
    t.integer "fb_connect"
    t.string "fb_id", limit: 300
    t.string "access_token", limit: 500
    t.string "long_live_token", limit: 500
    t.integer "twitter_connect"
    t.string "twitter_id", limit: 300
    t.integer "google_connect"
    t.string "google_id", limit: 300
    t.integer "linkedin_connect"
    t.string "linkedin_id", limit: 300
    t.integer "youtube_connect"
    t.string "youtube_id", limit: 250
    t.date "date"
    t.integer "invite"
    t.integer "response"
    t.datetime "login_time"
    t.integer "paid"
    t.integer "online"
    t.string "auto_report", limit: 200
    t.integer "report_sent_count"
    t.date "report_sent_date"
    t.date "report_send_date"
    t.string "current_plan", limit: 200
    t.string "plan_id", limit: 20
    t.string "plan_amount", limit: 200
    t.date "expiry_date"
    t.date "expiry_notification_date"
    t.date "purchase_date"
    t.datetime "last_login"
    t.string "login_location", limit: 500
    t.date "registered_date"
    t.date "payment_reminder_date"
    t.integer "beta"
    t.integer "cancel"
    t.string "extended_until", limit: 50
    t.string "username", limit: 55
    t.integer "Joeycrowd"
    t.string "email_verify", limit: 100
    t.integer "account_limit"
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.string "timezone"
    t.bigint "organisation_id"
    t.bigint "office_id"
    t.string "stripe_customer_id"
    t.boolean "is_new_design", default: true
    t.string "bio"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 500, default: "", null: false
    t.index ["email"], name: "index_hq_users_on_email"
    t.index ["office_id"], name: "index_hq_users_on_office_id"
    t.index ["organisation_id"], name: "index_hq_users_on_organisation_id"
    t.index ["reset_password_token"], name: "index_hq_users_on_reset_password_token"
  end

  create_table "insights_youtube", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "googleid", null: false
    t.string "title", limit: 200, null: false
    t.string "videoId", limit: 300, null: false
    t.string "publishedAt", limit: 300, null: false
    t.string "channelId", limit: 500, null: false
    t.text "thumbnails", null: false
    t.string "channelTitle", limit: 200, null: false
    t.string "playlistId", limit: 200, null: false
    t.bigint "position", null: false
    t.bigint "viewCount", null: false
    t.integer "likeCount", null: false
    t.integer "dislikeCount", null: false
    t.integer "commentCount", null: false
    t.bigint "user_id", null: false
    t.bigint "total_count", null: false
    t.integer "favoriteCount", null: false
    t.index ["user_id"], name: "userid"
  end

  create_table "insta_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 230, null: false
    t.string "username", limit: 230, null: false
    t.string "password", limit: 230, null: false
    t.integer "userid", null: false
    t.string "org_id", limit: 100, null: false
  end

  create_table "km_competitor", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "comp_id", null: false, auto_increment: true
    t.integer "comp_userid", null: false
    t.integer "comp_pageid", null: false
    t.string "comp_page_type", limit: 10, null: false
    t.datetime "comp_created_at", null: false
    t.string "comp_status", limit: 6, null: false
    t.index ["comp_id"], name: "comp_id", unique: true
  end

  create_table "km_curl_session", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "curl_id", null: false, auto_increment: true
    t.integer "curl_userid", null: false
    t.string "curl_type", limit: 20, null: false
    t.string "curl_subtype", limit: 25, null: false
    t.datetime "curl_createdate", null: false
    t.string "curl_log", limit: 512, null: false
    t.boolean "curl_status", null: false
    t.index ["curl_id"], name: "curl_id", unique: true
  end

  create_table "km_facebookpages", primary_key: "km_fbpageid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "fb_pageid", limit: 15, null: false
    t.string "fb_about", limit: 100, null: false
    t.string "fb_category", limit: 100, null: false
    t.string "fb_cover_source", limit: 300, null: false
    t.string "fb_brand_root_id", limit: 20, null: false
    t.boolean "fb_has_added_app", null: false
    t.boolean "fb_is_community_page", null: false
    t.boolean "fb_is_published", null: false
    t.string "fb_page_likes", limit: 15, null: false
    t.string "fb_page_link", limit: 150, null: false
    t.string "fb_page_name", limit: 100, null: false
    t.string "fb_talking_about_count", limit: 10, null: false
    t.string "fb_page_username", limit: 25, null: false
    t.string "fb_page_website", limit: 150, null: false
    t.string "fb_were_here_count", limit: 15, null: false
    t.integer "fb_search_id", null: false
    t.datetime "fb_create_date", null: false
    t.boolean "fb_status", null: false
    t.index ["km_fbpageid"], name: "km_fbpageid"
    t.index ["km_fbpageid"], name: "km_fbpageid_2", unique: true
  end

  create_table "km_google_plus", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "km_gpid", null: false, auto_increment: true
    t.string "km_gplus_id", limit: 25, null: false
    t.string "km_gp_displayName", limit: 20, null: false
    t.string "km_gp_image", limit: 300, null: false
    t.string "km_gp_views", limit: 11, null: false
    t.string "km_gp_plusone", limit: 11, null: false
    t.string "km_gp_followers", limit: 11, null: false
    t.string "km_post_count", limit: 11, null: false
    t.string "km_comment", limit: 11, null: false
    t.string "km_reshare", limit: 11, null: false
    t.string "km_search_id", limit: 11, null: false
    t.datetime "km_createat", null: false
    t.boolean "km_status", null: false
    t.index ["km_gpid"], name: "km_gpid", unique: true
  end

  create_table "km_instagram", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "km_instagram_id", null: false, auto_increment: true
    t.integer "insta_id", null: false
    t.string "insta_username", limit: 25, null: false
    t.string "insta_bio", limit: 350, null: false
    t.string "insta_website", limit: 50, null: false
    t.string "insta_image", limit: 500, null: false
    t.string "insta_full_name", limit: 30, null: false
    t.string "insta_media", limit: 10, null: false
    t.string "insta_followed_by", limit: 10, null: false
    t.string "insta_follows", limit: 10, null: false
    t.integer "km_search_id", null: false
    t.datetime "insta_created", null: false
    t.boolean "insta_status", null: false
    t.index ["km_instagram_id"], name: "km_instagram_id", unique: true
  end

  create_table "km_pagesearch", primary_key: "se_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "se_key", limit: 40, null: false
    t.string "se_content", limit: 100, null: false
    t.string "se_link", limit: 100, null: false
    t.string "se_title", limit: 50, null: false
    t.integer "se_count", null: false
    t.string "se_engine_type", limit: 6, null: false
    t.datetime "se_created_at", null: false
    t.integer "se_userid", null: false
    t.integer "se_pageid", null: false
    t.string "se_pagetype", limit: 10, null: false
    t.boolean "se_status", null: false
  end

  create_table "km_pinterest_profiles", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "pt_profile_id", limit: 50, null: false
    t.string "pt_username", limit: 50, null: false
    t.string "pt_firstname", limit: 50, null: false
    t.string "pt_lastname", limit: 50, null: false
    t.string "pt_bio", limit: 300, null: false
    t.string "pt_createdat", limit: 150, null: false
    t.string "pt_pins_count", limit: 10, null: false
    t.string "pt_following_counts", limit: 10, null: false
    t.string "pt_followers_count", limit: 10, null: false
    t.string "pt_boards_count", limit: 10, null: false
    t.string "pt_likes_count", limit: 10, null: false
    t.string "pt_image", limit: 512, null: false
    t.boolean "pt_status", null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "km_twitterpages", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "km_twitid", null: false, auto_increment: true
    t.string "twit_page_id", limit: 15, null: false
    t.string "twit_page_name", limit: 100, null: false
    t.string "twit_page_screenname", limit: 100, null: false
    t.string "twit_page_location", limit: 100, null: false
    t.string "twit_page_profile_location", limit: 100, null: false
    t.string "description", limit: 500, null: false
    t.string "twit_page_expanded_url", limit: 150, null: false
    t.integer "twit_page_followers_count", null: false
    t.integer "twit_page_friends_count", null: false
    t.integer "twit_page_listed_count", null: false
    t.string "twit_page_created_at", limit: 50, null: false
    t.integer "twit_page_favourites_count", null: false
    t.integer "twit_page_statuses_count", null: false
    t.boolean "twit_page_profile_use_background_image", null: false
    t.string "twit_page_profile_background_image_url", limit: 300, null: false
    t.string "twit_page_profile_background_image_url_https", limit: 300, null: false
    t.string "twit_page_profile_image_url", limit: 300, null: false
    t.string "twit_page_profile_image_url_https", limit: 300, null: false
    t.datetime "twit_create_date", null: false
    t.string "twit_searchid", limit: 10, null: false
    t.boolean "twit_status", null: false
    t.index ["km_twitid"], name: "km_twitid", unique: true
  end

  create_table "knack_admin_user", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "username", limit: 120, null: false
    t.string "email", limit: 120, null: false
    t.string "password", limit: 30, null: false
    t.integer "group_id", null: false
    t.datetime "last_login", null: false
    t.datetime "created_datetime", null: false
    t.datetime "modified_datetime", null: false
    t.integer "status", null: false
  end

  create_table "knack_ads", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 300, null: false
    t.string "title", limit: 300, null: false
    t.text "body", null: false
    t.string "ad_img", limit: 300, null: false
  end

  create_table "knack_blog", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "category_id", null: false
    t.string "blog_name", limit: 250, null: false
    t.string "meta_desc", limit: 250, null: false
    t.string "meta_keywords", limit: 250, null: false
    t.text "blog", null: false
    t.string "blog_image", limit: 250, null: false
    t.string "username", limit: 250, null: false
    t.text "keywords", null: false
    t.string "date", limit: 250, null: false
    t.integer "status", null: false
    t.integer "most_trending", null: false
  end

  create_table "knack_blog_subscription", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "email", limit: 200, null: false
    t.string "name", limit: 200, null: false
    t.string "status", null: false
  end

  create_table "knack_calendar_share", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 250, null: false
    t.string "email", limit: 250, null: false
    t.text "note", null: false
    t.string "permission", limit: 200, null: false
    t.integer "user_id", null: false
    t.string "profile", limit: 250, null: false
    t.integer "shared_with", null: false
    t.date "shared_date", null: false
  end

  create_table "knack_campaigns", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "adplace", limit: 300, null: false
    t.string "adset_name", limit: 300, null: false
    t.string "campaign_name", limit: 300, null: false
    t.integer "age_frm", null: false
    t.integer "age_to", null: false
    t.string "ad_name", limit: 300, null: false
    t.string "gender", limit: 200, null: false
    t.string "sdate", limit: 300, null: false
    t.string "edate", limit: 300, null: false
    t.string "ad_budget", limit: 300, null: false
    t.string "time_period", limit: 300, null: false
    t.string "bit_type", limit: 300, null: false
    t.string "bit_select", limit: 250, null: false
    t.string "bit_num", limit: 200, null: false
    t.string "setting", limit: 250, null: false
    t.string "ad_status", limit: 200, null: false
    t.string "adset_id", limit: 200, null: false
    t.string "campaign_id", limit: 300, null: false
    t.string "image_hash", limit: 300, null: false
    t.string "creative_id", limit: 300, null: false
    t.string "ad_group_id", limit: 300, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 200, null: false
    t.string "ad_accid", limit: 300, null: false
    t.string "network", limit: 100, null: false
  end

  create_table "knack_category", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "category_name", limit: 250, null: false
    t.integer "status", null: false
  end

  create_table "knack_chatmessages", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "team_member_id", null: false
    t.integer "team_manager_id", null: false
    t.text "name", null: false
    t.text "msg", null: false
    t.string "posted", limit: 20, null: false
  end

  create_table "knack_chatus", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "user_id", limit: 200, null: false
    t.integer "admin", null: false
    t.text "message", null: false
    t.datetime "date_time", null: false
    t.integer "open", null: false
  end

  create_table "knack_cms", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "privacy_policy", null: false
    t.text "terms", null: false
  end

  create_table "knack_comments", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "description", null: false
    t.integer "user_id", null: false
    t.text "profile_id", null: false
    t.date "event_date", null: false
    t.integer "post_id", null: false
    t.date "current_date", null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "knack_customer_service", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "subject", limit: 250, null: false
    t.text "description", null: false
    t.text "reply", null: false
    t.string "last_update", limit: 250, null: false
    t.string "attachment", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "status", limit: 250, null: false
    t.date "dat", null: false
  end

  create_table "knack_discover_search_datas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.integer "team_member_id", null: false
    t.integer "team_post", null: false
    t.string "team_post_type", limit: 30, null: false
    t.string "network", limit: 30, null: false
    t.string "search_type", limit: 30, null: false
    t.string "keyword", limit: 30, null: false
    t.string "name", limit: 50, null: false
    t.string "profile_url", limit: 200, null: false
    t.string "link", limit: 200, null: false
    t.string "text", limit: 1000, null: false
    t.string "likes_count", limit: 10, null: false
    t.string "img_url", limit: 300, null: false
    t.string "video_url", limit: 300, null: false
    t.string "media_count", limit: 10, null: false
    t.string "followers", limit: 10, null: false
    t.string "following", limit: 10, null: false
    t.string "category", limit: 200, null: false
    t.string "favourites_count", limit: 10, null: false
    t.string "created_at", limit: 50, null: false
    t.string "category_assign", limit: 30, null: false
    t.text "category_text", null: false
    t.string "image_upload", limit: 200, null: false
    t.string "suggested_date", limit: 20, null: false
    t.string "org_id", limit: 20, null: false
  end

  create_table "knack_email_template", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 250, null: false
    t.text "template", null: false
    t.integer "status", null: false
  end

  create_table "knack_facebook_competitor", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "page_id", limit: 100, null: false
    t.string "page_name", limit: 300, null: false
    t.string "access_token", limit: 300, null: false
    t.string "user_id", limit: 100, null: false
    t.string "basepageid", limit: 100, null: false
    t.string "profile_id", limit: 100, null: false
  end

  create_table "knack_facebook_data", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.integer "group_count", null: false
    t.integer "page_count", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.integer "friends_count", null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.date "tdate", null: false
  end

  create_table "knack_fb_chart_last30", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "page_id", limit: 100, null: false
    t.string "chart_name", limit: 200, null: false
    t.text "json_data", null: false
    t.datetime "last_update", null: false
  end

  create_table "knack_fb_chart_last7", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "page_id", limit: 100, null: false
    t.string "chart_name", limit: 200, null: false
    t.text "json_data", null: false
    t.datetime "last_update", null: false
  end

  create_table "knack_fb_chart_lastmonth", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "page_id", limit: 100, null: false
    t.string "chart_name", limit: 200, null: false
    t.text "json_data", null: false
    t.datetime "last_update", null: false
  end

  create_table "knack_fb_chart_thismonth", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "page_id", limit: 100, null: false
    t.string "chart_name", limit: 200, null: false
    t.text "json_data", null: false
    t.datetime "last_update", null: false
  end

  create_table "knack_fb_chart_today", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "page_id", limit: 100, null: false
    t.string "chart_name", limit: 200, null: false
    t.text "json_data", null: false
    t.datetime "last_update", null: false
  end

  create_table "knack_fb_groups", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "group_name", limit: 250, null: false
    t.string "group_id", limit: 250, null: false
    t.string "category", limit: 500, null: false
    t.text "access_token", null: false
    t.string "profile_id", limit: 250, null: false
    t.integer "user_id", null: false
    t.integer "connect", null: false
  end

  create_table "knack_forum_category", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "category_name", limit: 250, null: false
    t.integer "status", null: false
  end

  create_table "knack_general_settings", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "website_name", limit: 250, null: false
    t.string "address", limit: 250, null: false
    t.string "phone", limit: 250, null: false
    t.string "from_email", limit: 250, null: false
    t.string "url", limit: 250, null: false
    t.string "bcc_mail", limit: 250, null: false
    t.string "admin_mail_id", limit: 100, null: false
    t.string "paypal_email", limit: 250, null: false
    t.integer "paypal_payment_type", null: false
  end

  create_table "knack_goals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.integer "fb_friends", default: 0, null: false
    t.integer "fb_page", default: 0, null: false
    t.integer "fb_page_liked", default: 0, null: false
    t.integer "fb_post", default: 0, null: false
    t.integer "fb_reach", null: false
    t.integer "fb_visit", null: false
    t.integer "fbpg_imp_uni", null: false
    t.integer "fbpg_imp_paid", null: false
    t.integer "fbpg_imp_org_uni", null: false
    t.integer "fbpg_imp_vir_uni", null: false
    t.integer "fbpg_fan", null: false
    t.integer "fbpg_engage", null: false
    t.integer "fbpg_stories", null: false
    t.integer "tw_followers", default: 0, null: false
    t.integer "tw_following", default: 0, null: false
    t.integer "tw_tweet", default: 0, null: false
    t.integer "tw_retweet", default: 0, null: false
    t.integer "tw_post", null: false
    t.integer "go_follows", default: 0, null: false
    t.integer "go_following", default: 0, null: false
    t.integer "go_pages", default: 0, null: false
    t.integer "go_posts", default: 0, null: false
    t.integer "go_view", null: false
    t.integer "lk_likes", default: 0, null: false
    t.integer "lk_impression", default: 0, null: false
    t.integer "lk_engage", default: 0, null: false
    t.integer "lk_shares", default: 0, null: false
    t.integer "lk_post", null: false
    t.string "type", limit: 30, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "ins_likes", null: false
    t.integer "ins_engage", null: false
    t.integer "ins_shares", null: false
    t.integer "ins_board", null: false
    t.integer "ins_Following", null: false
    t.integer "you_like", null: false
    t.integer "you_unlike", null: false
    t.integer "you_comment", null: false
    t.integer "you_fav", null: false
    t.integer "you_view", null: false
    t.integer "pin_pin", null: false
    t.integer "pin_board", null: false
    t.integer "pin_command", null: false
    t.integer "pin_followers", null: false
    t.integer "pin_following", null: false
    t.integer "pin_repin", null: false
    t.integer "pin_like", null: false
  end

  create_table "knack_group_members", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "group_id", null: false
    t.integer "member_id", null: false
    t.integer "user_id", null: false
    t.integer "status", null: false
    t.integer "invite_status", null: false
    t.integer "respond", null: false
  end

  create_table "knack_groups", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "group_name", limit: 250, null: false
    t.text "description", null: false
    t.string "group_profile", limit: 250, null: false
    t.integer "user_id", null: false
    t.integer "status", null: false
  end

  create_table "knack_ideas_category", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.string "category_name", limit: 100, null: false
    t.integer "status", null: false
    t.string "bg_color", limit: 10, null: false
    t.string "font_color", limit: 10, null: false
    t.string "org_id", limit: 20, null: false
  end

  create_table "knack_impression", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "impression", null: false
    t.date "date", null: false
    t.string "page_id", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "type", limit: 100, null: false
  end

  create_table "knack_inbox", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "from_user_id", null: false
    t.integer "to_user_id", null: false
    t.string "from_type", limit: 250, null: false
    t.string "to_type", limit: 250, null: false
    t.string "from_user_name", limit: 250, null: false
    t.string "to_user_name", limit: 250, null: false
    t.string "subject", limit: 250, null: false
    t.text "message", null: false
    t.string "from_user_deleted", limit: 250, default: "no", null: false
    t.string "to_user_deleted", limit: 250, default: "no", null: false
    t.string "from_archive", limit: 250, default: "no", null: false
    t.string "to_archive", limit: 250, default: "no", null: false
    t.string "from_user_read", limit: 250, default: "no", null: false
    t.string "to_user_read", limit: 250, default: "no", null: false
    t.integer "msg_reply_id", null: false
    t.integer "from_reply_id", null: false
    t.integer "to_reply_id", null: false
    t.integer "reply_count", null: false
    t.string "am_pm", limit: 250, null: false
    t.string "hours_minutes", limit: 250, null: false
    t.timestamp "date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "reply_date", null: false
    t.string "from_deleted", limit: 5, default: "no", null: false
    t.string "to_deleted", limit: 5, default: "no", null: false
  end

  create_table "knack_inbox_files", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "inbox_id", null: false
    t.string "files_url", limit: 250, null: false
  end

  create_table "knack_inbox_reply", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "inbox_id", null: false
    t.integer "msg_reply_id", null: false
    t.text "message", null: false
    t.datetime "date", null: false
    t.string "hours_minutes", limit: 250, null: false
    t.integer "from_read", default: 0, null: false
    t.integer "to_read", default: 0, null: false
    t.string "am_pm", limit: 250, null: false
  end

  create_table "knack_instagram", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "image", null: false
    t.string "profile_id", limit: 250, null: false
    t.integer "user_id", null: false
    t.text "access_token", null: false
    t.string "houseq", limit: 11, null: false
  end

  create_table "knack_instagram_backup_Feb2016", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", default: 0, null: false
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.string "media_type", limit: 250, null: false
    t.integer "media_id", null: false
    t.string "videos", limit: 750, null: false
    t.integer "videos_widdth", null: false
    t.integer "videos_height", null: false
    t.datetime "created_time", null: false
  end

  create_table "knack_instagram_backup_Jan2016", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", default: 0, null: false
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.string "media_type", limit: 250, null: false
    t.integer "media_id", null: false
    t.string "videos", limit: 750, null: false
    t.integer "videos_widdth", null: false
    t.integer "videos_height", null: false
    t.datetime "created_time", null: false
  end

  create_table "knack_instagram_comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.date "tdate", null: false
    t.string "comment_text", null: false
    t.string "comment_id", null: false
    t.integer "comment_from_id", null: false
    t.string "created_time", null: false
  end

  create_table "knack_instagram_data", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.string "media_type", limit: 250, null: false
    t.integer "media_id", null: false
    t.string "videos", limit: 750, null: false
    t.integer "videos_widdth", null: false
    t.integer "videos_height", null: false
    t.datetime "created_time", null: false
    t.string "has_liked", limit: 4, null: false
    t.text "post_id", null: false
  end

  create_table "knack_instagram_data_backup", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.integer "profile_id", null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.string "created_time", limit: 500, null: false
  end

  create_table "knack_instagram_data_bck2", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.datetime "created_time", null: false
  end

  create_table "knack_instagram_data_myisam", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.string "media_type", limit: 250, null: false
    t.integer "media_id", null: false
    t.string "videos", limit: 750, null: false
    t.integer "videos_widdth", null: false
    t.integer "videos_height", null: false
    t.datetime "created_time", null: false
    t.string "has_liked", limit: 4, null: false
    t.text "post_id", null: false
  end

  create_table "knack_instagram_data_v1", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.string "profile_id", limit: 100, null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
    t.bigint "baseuserid", null: false
    t.datetime "created_time", null: false
  end

  create_table "knack_instagram_datav1", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "liked_pages", null: false
    t.integer "post_count", null: false
    t.string "filter", null: false
    t.string "instagram_link", null: false
    t.integer "likes_count", null: false
    t.string "image", null: false
    t.string "width", null: false
    t.string "height", null: false
    t.string "caption_text", null: false
    t.integer "caption_id", null: false
    t.integer "following", null: false
    t.integer "followers", null: false
    t.string "type", null: false
    t.date "tdate", null: false
    t.integer "user_id", null: false
    t.string "username", null: false
    t.string "profile_picture", null: false
    t.integer "profile_id", null: false
    t.string "network_id", limit: 200, null: false
    t.string "full_name", null: false
  end

  create_table "knack_invite", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.integer "member_id", null: false
    t.integer "group_id", null: false
    t.integer "invite_status", null: false
    t.integer "respond", null: false
  end

  create_table "knack_linkedin_data", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "clicks", null: false
    t.integer "impression", null: false
    t.integer "likes", null: false
    t.integer "share", null: false
    t.text "engagement", null: false
    t.integer "follower", null: false
    t.integer "company_size", null: false
    t.integer "contry_reach", null: false
    t.text "country_data", null: false
    t.integer "comments", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.string "linkedin_id", limit: 200, null: false
    t.string "page_id", limit: 3000, null: false
    t.date "today_date", null: false
    t.integer "user_id", null: false
  end

  create_table "knack_main_tabs", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "tab_name", limit: 300, null: false
    t.integer "user_id", null: false
  end

  create_table "knack_monitor_backup_Dec2015", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_monitor_backup_Feb2016", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", null: false
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_monitor_backup_Jan2016", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_monitor_backup_Mar2016", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "data_id", null: false
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_monitor_data", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
    t.string "visitor_id", limit: 300, null: false
    t.string "page_id", limit: 300, null: false
  end

  create_table "knack_monitor_data_innodbtest", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "post_id", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.string "id_str", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.text "title", null: false, collation: "latin1_swedish_ci"
    t.string "post_image", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.text "content", null: false, collation: "latin1_swedish_ci"
    t.string "link", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.string "profile_img", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false, collation: "latin1_swedish_ci"
    t.text "sec_token", null: false, collation: "latin1_swedish_ci"
    t.string "fname", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.string "lname", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.string "network", limit: 200, null: false, collation: "latin1_swedish_ci"
    t.string "type", limit: 250, null: false, collation: "latin1_swedish_ci"
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false, collation: "latin1_swedish_ci"
    t.string "date", limit: 200, null: false, collation: "latin1_swedish_ci"
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false, collation: "latin1_swedish_ci"
    t.string "offset_user", limit: 50, null: false, collation: "latin1_swedish_ci"
  end

  create_table "knack_news_letter", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "template_id", null: false
    t.integer "group_id", null: false
    t.string "subject", limit: 250, null: false
    t.string "from_email", limit: 250, null: false
    t.text "content", null: false
  end

  create_table "knack_news_letter_group", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 250, null: false
    t.integer "email_limit", null: false
    t.integer "status", null: false
  end

  create_table "knack_news_letter_subscription", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.string "email", limit: 200, null: false
    t.integer "status", null: false
  end

  create_table "knack_news_letter_template", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 250, null: false
    t.text "template", null: false
    t.integer "status", null: false
  end

  create_table "knack_orgs", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "org_name", limit: 100, null: false
    t.integer "user_id", null: false
  end

  create_table "knack_pages", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "page_id", limit: 200, null: false
    t.string "page_name", limit: 250, null: false
    t.text "profile_image", null: false
    t.integer "connect", null: false
    t.text "access_token", null: false
    t.string "profile_id", limit: 300, null: false
    t.integer "user_id", null: false
    t.string "network", limit: 250, null: false
    t.string "page_type", limit: 126, null: false
    t.string "org_id", limit: 100, null: false
    t.string "houseq", limit: 11, null: false
    t.string "connect_ads", limit: 30, null: false
    t.integer "token_expired", null: false
    t.text "error", null: false
    t.integer "disable_que", null: false
  end

  create_table "knack_pages_new", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "page_id", limit: 200, null: false
    t.string "page_name", limit: 250, null: false
    t.text "profile_image", null: false
    t.integer "connect", null: false
    t.text "access_token", null: false
    t.string "profile_id", limit: 300, null: false
    t.integer "user_id", null: false
    t.string "network", limit: 250, null: false
    t.string "page_type", limit: 126, null: false
  end

  create_table "knack_payments", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "order_id", null: false
    t.integer "user_id", null: false
    t.integer "amount", null: false
    t.date "payment_date", null: false
    t.integer "plan_id", null: false
    t.date "expiry_date", null: false
  end

  create_table "knack_pin_board", primary_key: "km_board_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "printe_profile_id", limit: 25, null: false
    t.string "board_id", limit: 25, null: false
    t.string "board_name", limit: 100, null: false
    t.string "board_url", limit: 512, null: false
    t.string "board_desc", limit: 300, null: false
    t.string "board_img", limit: 512, null: false
    t.string "bord_pin_count", limit: 10, null: false
    t.string "board_followers", limit: 10, null: false
    t.string "board_collaborators", limit: 10, null: false
    t.string "km_userid", limit: 10, null: false
    t.boolean "km_board_status", null: false
    t.index ["km_board_id"], name: "km_board_id", unique: true
  end

  create_table "knack_pinterest_followers", primary_key: "km_followes_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "km_pinterestprofile_id", limit: 25, null: false
    t.string "pintr_flwr_id", limit: 25, null: false
    t.string "flwr_username", limit: 50, null: false
    t.string "flwr_image", limit: 512, null: false
    t.string "flwr_bio", limit: 500, null: false
    t.string "flwr_pins_count", limit: 10, null: false
    t.string "flwr_flwing_count", limit: 10, null: false
    t.string "flwr_board_count", limit: 10, null: false
    t.string "flwr_likes_count", limit: 10, null: false
    t.string "flwr_flwr_count", limit: 10, null: false
    t.string "flwr_tab_info", limit: 250, null: false
    t.boolean "flwr_status", null: false
    t.index ["km_followes_id"], name: "km_followes_id", unique: true
  end

  create_table "knack_pinterest_following-boards", primary_key: "knack_following-boards_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "flwing-b_id", limit: 25, null: false
    t.string "flwing-b_name", limit: 100, null: false
    t.string "flwing-b_desc", limit: 300, null: false
    t.string "flwing-b_image", limit: 512, null: false
    t.string "flwing-b_pins_counts", limit: 10, null: false
    t.string "flwing-b_boards_counts", limit: 10, null: false
    t.string "flwing-b_url", limit: 512, null: false
    t.string "flwing-b_tab_info", limit: 250, null: false
    t.boolean "flwing-b_status", null: false
    t.index ["knack_following-boards_id"], name: "knack_following-boards_id", unique: true
  end

  create_table "knack_pinterest_following-users", primary_key: "km_following-users_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "pintr_flwing_id", limit: 25, null: false
    t.string "flwng_username", limit: 50, null: false
    t.string "flwng_image", limit: 512, null: false
    t.string "flwng_bio", limit: 500, null: false
    t.string "flwng_pins_counts", limit: 10, null: false
    t.string "flwng_folllowing_counts", limit: 10, null: false
    t.string "flwng_boards_counts", limit: 10, null: false
    t.string "flwng_flwr_counts", limit: 10, null: false
    t.string "flwng_likes_counts", limit: 10, null: false
    t.string "flwng_tab_info", limit: 250, null: false
    t.boolean "flwng_users_status", null: false
    t.index ["km_following-users_id"], name: "km_following_id", unique: true
  end

  create_table "knack_pinterest_pin", primary_key: "km_pin_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "pin_id", limit: 25, null: false
    t.string "pin_link", limit: 512, null: false
    t.string "pin_url", limit: 512, null: false
    t.string "pin_creator_id", limit: 50, null: false
    t.string "pin_board_id", limit: 50, null: false
    t.string "pin_note", limit: 300, null: false
    t.string "pin_like_counts", limit: 10, null: false
    t.string "pin_comments_counts", limit: 10, null: false
    t.string "pin_repin_counts", limit: 10, null: false
    t.string "pin_media_url", limit: 512, null: false
    t.string "attribution", limit: 512, null: false
    t.string "pin_media_type", limit: 5, null: false
    t.string "pin_metadata", limit: 500, null: false
    t.string "pin_userid", limit: 10, null: false
    t.boolean "pin_status", null: false
    t.index ["km_pin_id"], name: "km_pin_id", unique: true
  end

  create_table "knack_portfolio", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 50, null: false
    t.string "linkedin_title", limit: 300, null: false
    t.text "description", null: false
    t.text "fb_text_des", null: false
    t.text "twit_text_des", null: false
    t.text "lin_text_des", null: false
    t.text "pin_text_des", null: false
    t.text "gp_text_des", null: false
    t.text "fb_description", null: false
    t.text "twitter_description", null: false
    t.text "link_description", null: false
    t.text "pin_description", null: false
    t.text "linkedin_description", null: false
    t.text "post_url", null: false
    t.text "linkedin_url", null: false
    t.string "post_img", limit: 250, null: false
    t.string "post_img2", limit: 250, null: false
    t.string "post_img3", limit: 250, null: false
    t.string "post_img4", limit: 250, null: false
    t.text "album_images", null: false
    t.string "post_album", null: false
    t.text "linkedin_image", null: false
    t.string "post_type", limit: 100, null: false
    t.text "facebook", null: false
    t.integer "fb_status", null: false
    t.text "fb_pages", null: false
    t.integer "fbpg_status", null: false
    t.text "fb_groups", null: false
    t.integer "fb_group_status", null: false
    t.text "twitter", null: false
    t.integer "twitter_status", null: false
    t.text "google_plus", null: false
    t.integer "gplus_status", null: false
    t.text "pinterest", null: false
    t.integer "pinterest_status", null: false
    t.integer "pin_mail", default: 0, null: false
    t.text "linkedin", null: false
    t.integer "lin_status", null: false
    t.text "lin_pages", null: false
    t.integer "linpg_status", null: false
    t.integer "user_id", null: false
    t.datetime "schedule_date", null: false
    t.date "post_date", null: false
    t.date "origninal_scheduled_date", null: false
    t.string "post_time", limit: 250, null: false
    t.integer "status", null: false
    t.integer "status_draft_post", null: false
    t.string "post_date_report", limit: 50, null: false
    t.string "am_pm", limit: 10, null: false
    t.integer "team_member_id", null: false
    t.integer "is_approved", limit: 1, null: false
    t.text "reason", null: false
    t.string "sentto", limit: 20, null: false
    t.string "category_name", limit: 50, null: false
    t.string "category_bg", limit: 20, null: false
    t.text "instagram", null: false
    t.integer "instagram_status", null: false
    t.text "instagram_description", null: false
    t.string "sched_id", limit: 20, null: false
    t.integer "level", null: false
    t.integer "catid", null: false
  end

  create_table "knack_post", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 50
    t.string "linkedin_title", limit: 300
    t.text "description"
    t.text "fb_text_des"
    t.text "twit_text_des"
    t.text "lin_text_des"
    t.text "pin_text_des"
    t.text "gp_text_des"
    t.text "fb_description"
    t.text "twitter_description"
    t.text "link_description"
    t.text "pin_description"
    t.text "linkedin_description"
    t.text "post_url"
    t.text "linkedin_url"
    t.string "post_img", limit: 250
    t.text "album_images"
    t.string "post_album"
    t.text "linkedin_image"
    t.string "post_type", limit: 100
    t.text "facebook"
    t.integer "fb_status"
    t.text "fb_pages"
    t.integer "fbpg_status"
    t.text "fb_groups"
    t.integer "fb_group_status"
    t.text "twitter"
    t.integer "twitter_status"
    t.text "google_plus"
    t.integer "gplus_status"
    t.text "pinterest"
    t.integer "pinterest_status"
    t.integer "pin_mail", default: 0
    t.text "linkedin"
    t.integer "lin_status"
    t.text "lin_pages"
    t.integer "linpg_status"
    t.integer "user_id"
    t.datetime "schedule_date"
    t.date "post_date"
    t.date "origninal_scheduled_date"
    t.string "post_time", limit: 250
    t.integer "status"
    t.integer "status_draft_post"
    t.string "post_date_report", limit: 50
    t.string "am_pm", limit: 10
    t.integer "team_member_id"
    t.integer "is_approved", limit: 1
    t.text "reason"
    t.string "sentto", limit: 20
    t.string "category_name", limit: 50
    t.string "category_bg", limit: 20
    t.text "instagram"
    t.integer "instagram_status"
    t.text "instagram_description"
    t.string "sched_id", limit: 20
    t.integer "portfolio_id"
    t.string "houseq", limit: 10
    t.integer "catid"
    t.text "ins_text_des"
    t.bigint "queue_list_id"
    t.datetime "scheduled_at"
    t.string "utc_offset"
    t.datetime "created_at"
    t.string "image"
    t.string "subimage1"
    t.string "subimage2"
    t.string "subimage3"
    t.bigint "queue_post_id"
    t.datetime "updated_at"
    t.boolean "deployed", default: false
    t.integer "post_tasks_count", default: 0
    t.string "sub_img1"
    t.string "sub_img2"
    t.string "sub_img3"
    t.string "timezone_str", default: "UTC"
    t.string "other_image_url"
    t.index ["queue_list_id"], name: "index_knack_post_on_queue_list_id"
    t.index ["queue_post_id"], name: "index_knack_post_on_queue_post_id"
  end

  create_table "knack_post_BAK", id: :integer, default: nil, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 50, null: false
    t.string "linkedin_title", limit: 300, null: false
    t.text "description", null: false
    t.text "fb_text_des", null: false
    t.text "twit_text_des", null: false
    t.text "lin_text_des", null: false
    t.text "pin_text_des", null: false
    t.text "gp_text_des", null: false
    t.text "fb_description", null: false
    t.text "twitter_description", null: false
    t.text "link_description", null: false
    t.text "pin_description", null: false
    t.text "linkedin_description", null: false
    t.text "post_url", null: false
    t.text "linkedin_url", null: false
    t.string "post_img", limit: 250, null: false
    t.text "album_images", null: false
    t.string "post_album", null: false
    t.text "linkedin_image", null: false
    t.string "post_type", limit: 100, null: false
    t.text "facebook", null: false
    t.integer "fb_status", null: false
    t.text "fb_pages", null: false
    t.integer "fbpg_status", null: false
    t.text "fb_groups", null: false
    t.integer "fb_group_status", null: false
    t.text "twitter", null: false
    t.integer "twitter_status", null: false
    t.text "google_plus", null: false
    t.integer "gplus_status", null: false
    t.text "pinterest", null: false
    t.integer "pinterest_status", null: false
    t.integer "pin_mail", default: 0, null: false
    t.text "linkedin", null: false
    t.integer "lin_status", null: false
    t.text "lin_pages", null: false
    t.integer "linpg_status", null: false
    t.integer "user_id", null: false
    t.datetime "schedule_date", null: false
    t.date "post_date", null: false
    t.date "origninal_scheduled_date", null: false
    t.string "post_time", limit: 250, null: false
    t.integer "status", null: false
    t.integer "status_draft_post", null: false
    t.string "post_date_report", limit: 50, null: false
    t.string "am_pm", limit: 10, null: false
    t.integer "team_member_id", null: false
    t.integer "is_approved", limit: 1, null: false
    t.text "reason", null: false
    t.string "sentto", limit: 20, null: false
    t.string "category_name", limit: 50, null: false
    t.string "category_bg", limit: 20, null: false
    t.text "instagram", null: false
    t.integer "instagram_status", null: false
    t.text "instagram_description", null: false
    t.string "sched_id", limit: 20, null: false
    t.integer "portfolio_id", null: false
    t.string "houseq", limit: 10, null: false
  end

  create_table "knack_post_decline", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 50, null: false
    t.string "linkedin_title", limit: 300, null: false
    t.text "description", null: false
    t.text "fb_description", null: false
    t.text "twitter_description", null: false
    t.text "link_description", null: false
    t.text "linkedin_description", null: false
    t.text "post_url", null: false
    t.text "linkedin_url", null: false
    t.string "post_img", limit: 250, null: false
    t.text "album_images", null: false
    t.string "post_album", null: false
    t.text "linkedin_image", null: false
    t.string "post_type", limit: 100, null: false
    t.text "facebook", null: false
    t.integer "fb_status", null: false
    t.text "fb_pages", null: false
    t.integer "fbpg_status", null: false
    t.text "fb_groups", null: false
    t.integer "fb_group_status", null: false
    t.text "twitter", null: false
    t.integer "twitter_status", null: false
    t.text "google_plus", null: false
    t.integer "gplus_status", null: false
    t.text "pinterest", null: false
    t.integer "pinterest_status", null: false
    t.integer "pin_mail", default: 0, null: false
    t.text "linkedin", null: false
    t.integer "lin_status", null: false
    t.text "lin_pages", null: false
    t.integer "linpg_status", null: false
    t.integer "user_id", null: false
    t.datetime "schedule_date", null: false
    t.date "post_date", null: false
    t.date "origninal_scheduled_date", null: false
    t.string "post_time", limit: 250, null: false
    t.integer "status", null: false
    t.string "post_date_report", limit: 50, null: false
    t.string "am_pm", limit: 10, null: false
    t.integer "team_member_id", null: false
    t.integer "is_approved", limit: 1, null: false
    t.text "reason", null: false
  end

  create_table "knack_profile_grouping", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "group_name", limit: 250, null: false
    t.string "user_id", limit: 250, null: false
    t.text "grouping_profiles", null: false
    t.date "created_date", null: false
  end

  create_table "knack_profiles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "network_id", limit: 200, null: false
    t.string "profile_email", limit: 300, null: false
    t.string "network", limit: 250, null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.text "profile_pic", null: false
    t.string "profile_id", limit: 300, null: false
    t.text "access_token", null: false
    t.text "refresh_token", null: false
    t.string "long_live_token", limit: 500, null: false
    t.integer "followers", null: false
    t.integer "following", null: false
    t.integer "others", null: false
    t.integer "user_id", null: false
    t.string "expires_in", limit: 100, null: false
    t.string "expires_at", limit: 100, null: false
    t.string "org_id", limit: 20, null: false
    t.string "password", limit: 50, null: false
    t.string "username", limit: 50, null: false
    t.integer "houseq", null: false
    t.integer "token_expired", null: false
    t.text "error", null: false
    t.integer "disable_que", null: false
    t.boolean "verified", default: false
    t.index ["user_id"], name: "user_id"
    t.index ["user_id"], name: "user_id_2"
    t.index ["user_id"], name: "user_id_3"
  end

  create_table "knack_recent_search", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", null: false, auto_increment: true
    t.text "keyword", null: false
    t.date "search_date", null: false
    t.string "network", limit: 200, null: false
    t.string "search_type", limit: 200, null: false
    t.integer "user_id", null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "knack_reports_history", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id", null: false
    t.text "report", null: false
    t.string "report_type", limit: 50, null: false
    t.date "sent_date", null: false
  end

  create_table "knack_rss", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "content", null: false
    t.string "tag_name", limit: 500, null: false
    t.text "link", null: false
    t.string "rss_image", limit: 250, null: false
    t.date "rss_date", null: false
    t.integer "user_id", null: false
    t.index ["id"], name: "id", unique: true
  end

  create_table "knack_search", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "keyword", null: false
    t.date "saved_date", null: false
    t.string "network", limit: 200, null: false
    t.string "search_type", limit: 200, null: false
    t.integer "user_id", null: false
    t.string "org_id", limit: 20, null: false
  end

  create_table "knack_service_history", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "request_id", null: false
    t.string "user_id", limit: 200, null: false
    t.text "description", null: false
    t.string "status", limit: 250, null: false
    t.datetime "request_date", null: false
  end

  create_table "knack_stripe_subscription", primary_key: "stripe_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "stripe_customer_id", limit: 100, null: false
    t.string "stripe_customer_email", limit: 250, null: false
    t.string "stripe_customer_planid", limit: 250, null: false
    t.string "stripe_customer_plan_amount", limit: 250, null: false
    t.datetime "stripe_customer_created", null: false
    t.integer "stripe_user_id", null: false
    t.string "stripe_customer_name", limit: 250, null: false
    t.string "stripe_subscripe_id", limit: 250, null: false
    t.datetime "stripe_trial_start", null: false
    t.datetime "stripe_trial_ends", null: false
  end

  create_table "knack_subscribe", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "user_id", limit: 10, null: false
    t.string "email_id", limit: 50, null: false
    t.string "feed_type", limit: 50, null: false
    t.string "mail_frequent", limit: 30, null: false
  end

  create_table "knack_support_resources", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 250, null: false
    t.text "description", null: false
    t.integer "status", null: false
  end

  create_table "knack_tab", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "tab_id", limit: 300, null: false
    t.string "main_tab_id", limit: 300, null: false
    t.integer "display", null: false
    t.integer "user_id", null: false
    t.string "tab", limit: 50, null: false
  end

  create_table "knack_tasks", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 250, null: false
    t.text "description", null: false
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.integer "assigned_user_id", null: false
    t.string "task_status", limit: 250, null: false
  end

  create_table "knack_team_members", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "fname", limit: 50, null: false
    t.string "lname", limit: 50, null: false
    t.string "username", limit: 50, null: false
    t.string "password", limit: 50, null: false
    t.string "email_id", limit: 50, null: false
    t.string "permission", limit: 200, null: false
    t.string "team_manager", limit: 20, null: false
    t.string "status", limit: 50, null: false
    t.string "member_type", limit: 20, null: false
    t.string "org_id", limit: 11, null: false
  end

  create_table "knack_test", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", default: 0, null: false
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_test1", id: false, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "id", default: 0, null: false
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_test_table", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "list_id", limit: 100, null: false
    t.string "profile_id", limit: 100, null: false
    t.string "access_token", limit: 100, null: false
    t.string "long_live_token", limit: 100, null: false
    t.string "user_id", limit: 50, null: false
    t.integer "diff_num", null: false
    t.index ["list_id"], name: "list_id", unique: true
  end

  create_table "knack_timezone", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "gmt", limit: 250, null: false
    t.string "name", limit: 250, null: false
    t.integer "status", null: false
  end

  create_table "knack_twitter_data", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "followers", null: false
    t.integer "friends", null: false
    t.integer "tweets", null: false
    t.integer "retweets", null: false
    t.integer "mention", null: false
    t.integer "replay", null: false
    t.integer "favorites", null: false
    t.integer "mention_replay", null: false
    t.string "twitter_id", limit: 200, null: false
    t.date "today_date", null: false
    t.integer "user_id", null: false
  end

  create_table "knack_twitter_list_data", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "id_str", limit: 300, null: false
    t.string "list_id", limit: 100, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "subscribers", null: false
    t.integer "member_count", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_twitter_list_status", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "list_id", limit: 100, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "poster_id", limit: 100, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_twitter_mytweet", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "post_id", limit: 300, null: false
    t.string "id_str", limit: 300, null: false
    t.text "title", null: false
    t.string "post_image", limit: 300, null: false
    t.text "content", null: false
    t.string "link", limit: 300, null: false
    t.string "profile_img", limit: 300, null: false
    t.datetime "created_time", null: false
    t.integer "followers", null: false
    t.integer "lists", null: false
    t.integer "retweet", null: false
    t.integer "favorites", null: false
    t.integer "following", null: false
    t.integer "is_favorite", null: false
    t.text "acc_token", null: false
    t.text "sec_token", null: false
    t.string "fname", limit: 300, null: false
    t.string "lname", limit: 300, null: false
    t.string "network", limit: 200, null: false
    t.string "type", limit: 250, null: false
    t.integer "user_id", null: false
    t.string "profile_id", limit: 300, null: false
    t.string "date", limit: 200, null: false
    t.datetime "last_updated_at", null: false
    t.integer "indices_status", default: 0, null: false
    t.text "description", null: false
    t.string "offset_user", limit: 50, null: false
  end

  create_table "knack_users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "first_name", limit: 250, null: false
    t.string "last_name", limit: 250, null: false
    t.string "email", limit: 250, null: false
    t.string "user_type", limit: 17, null: false
    t.text "note", null: false
    t.string "password", limit: 250, null: false
    t.text "address", null: false
    t.string "phone", limit: 250, null: false
    t.string "country", limit: 250, null: false
    t.string "state", limit: 250, null: false
    t.string "city", limit: 250, null: false
    t.string "job_title", limit: 250, null: false
    t.string "company", limit: 250, null: false
    t.string "time_zone", limit: 250, null: false
    t.string "business_name", limit: 250, null: false
    t.string "assigning_tasks", limit: 250, null: false
    t.string "task_notification_emails", limit: 250, null: false
    t.string "fb_audience_confirmation", limit: 250, null: false
    t.string "fb_photo_upload", limit: 250, null: false
    t.string "profile_picture", limit: 250, null: false
    t.integer "status", default: 0, null: false
    t.integer "fb_connect", null: false
    t.string "fb_id", limit: 300, null: false
    t.string "access_token", limit: 500, null: false
    t.string "long_live_token", limit: 500, null: false
    t.integer "twitter_connect", null: false
    t.string "twitter_id", limit: 300, null: false
    t.integer "google_connect", null: false
    t.string "google_id", limit: 300, null: false
    t.integer "linkedin_connect", null: false
    t.string "linkedin_id", limit: 300, null: false
    t.integer "youtube_connect", null: false
    t.string "youtube_id", limit: 250, null: false
    t.date "date", null: false
    t.integer "invite", null: false
    t.integer "response", null: false
    t.datetime "login_time", null: false
    t.integer "paid", null: false
    t.integer "online", null: false
    t.string "auto_report", limit: 200, null: false
    t.integer "report_sent_count", null: false
    t.date "report_sent_date", null: false
    t.date "report_send_date", null: false
    t.string "current_plan", limit: 200, null: false
    t.string "plan_id", limit: 20, null: false
    t.string "plan_amount", limit: 200, null: false
    t.date "expiry_date", null: false
    t.date "expiry_notification_date", null: false
    t.date "purchase_date", null: false
    t.datetime "last_login", null: false
    t.string "login_location", limit: 500, null: false
    t.date "registered_date", null: false
    t.date "payment_reminder_date", null: false
    t.integer "beta", null: false
    t.integer "cancel", null: false
    t.string "extended_until", limit: 50, null: false
    t.string "username", limit: 55, null: false
    t.integer "Joeycrowd", null: false
    t.string "timezone"
    t.index ["id"], name: "id"
  end

  create_table "knackmap_ads", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 300, null: false
    t.string "title", limit: 300, null: false
    t.text "body", null: false
    t.string "ad_img", limit: 300, null: false
  end

  create_table "knackmap_facebook_message", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "from", null: false
    t.integer "to", null: false
    t.string "message", limit: 256, null: false
    t.string "subject", limit: 256, null: false
    t.string "tags", limit: 256, null: false
    t.datetime "created_time", null: false
  end

  create_table "knackmap_forum_answer", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "answer", limit: 250, null: false
    t.integer "qns_id", null: false
    t.integer "status", null: false
    t.integer "created_by", null: false
    t.datetime "created_date", null: false
  end

  create_table "knackmap_forum_qns", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "question", limit: 250, null: false
    t.integer "category_id", null: false
    t.integer "created_by", null: false
    t.datetime "created_date", null: false
    t.integer "status", null: false
  end

  create_table "linkpreview", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "text", null: false
    t.text "image", null: false
    t.text "title", null: false
    t.string "canonicalUrl", limit: 300, null: false
    t.string "url", limit: 500, null: false
    t.string "pageUrl", limit: 500, null: false
    t.text "description", null: false
    t.text "videoIframe", null: false
  end

  create_table "log_insta", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "manual", limit: 20, null: false
    t.string "email_sent", limit: 30, null: false
    t.text "log", null: false
    t.datetime "date", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "offices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.bigint "organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0
    t.integer "maximum_users_count", default: 10000
    t.bigint "payer_id"
    t.string "stripe_manager_subscription_id"
    t.string "stripe_agents_subscription_id"
    t.string "stripe_customer_id"
    t.index ["organisation_id"], name: "index_offices_on_organisation_id"
    t.index ["payer_id"], name: "index_offices_on_payer_id"
  end

  create_table "organisations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0
  end

  create_table "page_builder", primary_key: "pid", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "type", null: false
    t.integer "uid", null: false
    t.string "theme_color", limit: 55, null: false
    t.string "logo_img", null: false
    t.string "company_name", limit: 100, null: false
    t.string "property_title", null: false
    t.integer "listing_price", null: false
    t.string "description_Title", null: false
    t.text "long_description", null: false
    t.integer "bed", null: false
    t.integer "bath", null: false
    t.integer "parking", null: false
    t.integer "mls_number", null: false
    t.integer "street_number", null: false
    t.string "street_name", null: false
    t.string "city", null: false
    t.integer "zip_code", null: false
    t.string "country", limit: 55, null: false
    t.string "building_size", limit: 55, null: false
    t.string "lot_meter", limit: 55, null: false
    t.string "lot_size", limit: 55, null: false
    t.string "google_map_api", limit: 50, null: false
    t.string "floor_plan_img", limit: 55, null: false
    t.string "floor_plan_img2", limit: 55, null: false
    t.string "img_gallery1", limit: 55, null: false
    t.string "img_gallery2", limit: 55, null: false
    t.string "img_gallery3", limit: 55, null: false
    t.string "img_gallery4", limit: 55, null: false
    t.string "img_gallery5", limit: 55, null: false
    t.string "img_gallery6", limit: 55, null: false
    t.string "img_gallery7", limit: 55, null: false
    t.string "img_gallery8", limit: 55, null: false
    t.string "img_gallery9", limit: 55, null: false
    t.string "img_gallery10", limit: 55, null: false
    t.date "inspection_date", null: false
    t.time "inspection_time_from", null: false
    t.time "inspection_time_to", null: false
    t.string "agent_first_name", limit: 55, null: false
    t.string "agent_last_name", limit: 55, null: false
    t.string "agent_phone_number", limit: 55, null: false
    t.string "agent_email", limit: 55, null: false
    t.string "agent_photo", limit: 55, null: false
    t.string "facebook", limit: 55, null: false
    t.string "linkedin", limit: 55, null: false
    t.string "googleplus", limit: 55, null: false
    t.string "twitter", limit: 55, null: false
  end

  create_table "plusperson", primary_key: "plusperson_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string "googleplus_id", limit: 32, null: false
    t.string "profile_photo", null: false
    t.string "first_name", limit: 128, null: false
    t.string "last_name", limit: 128, null: false
    t.text "introduction", null: false
    t.text "subhead", null: false
    t.text "raw_data", null: false
    t.integer "fetched_relationships", default: 0, null: false
    t.date "created_dt", null: false
    t.date "modified_dt", null: false
    t.index ["googleplus_id"], name: "googleplus_id", unique: true
  end

  create_table "pluspost", primary_key: "pluspost_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string "googleplus_postid", limit: 128, null: false
    t.string "author_id", limit: 32, null: false
    t.text "post_data", null: false
    t.text "share_content", null: false
    t.string "shared_postid", limit: 128, null: false
    t.text "raw_data", null: false
    t.datetime "created_dt", null: false
    t.datetime "modified_dt", null: false
    t.index ["author_id"], name: "author_id"
    t.index ["googleplus_postid"], name: "googleplus_postid", unique: true
    t.index ["shared_postid"], name: "shared_postid"
  end

  create_table "plusrelationship", primary_key: "plusrelationship_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string "owner_id", limit: 32, null: false
    t.string "hasincircle_id", limit: 32, null: false
    t.datetime "created_dt", null: false
    t.datetime "modified_dt", null: false
    t.index ["hasincircle_id"], name: "hasincircle_id"
    t.index ["owner_id"], name: "owner_id"
  end

  create_table "post_profile_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "post_id"
    t.bigint "knack_pages_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["knack_pages_id"], name: "index_post_profile_pages_on_knack_pages_id"
    t.index ["post_id"], name: "index_post_profile_pages_on_post_id"
  end

  create_table "post_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "post_id"
    t.bigint "knack_profiles_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["knack_profiles_id"], name: "index_post_profiles_on_knack_profiles_id"
    t.index ["post_id"], name: "index_post_profiles_on_post_id"
  end

  create_table "post_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "post_id"
    t.string "profilable_type"
    t.bigint "profilable_id"
    t.text "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deployed", default: false
    t.index ["post_id"], name: "index_post_tasks_on_post_id"
    t.index ["profilable_type", "profilable_id"], name: "index_post_tasks_on_profilable_type_and_profilable_id"
  end

  create_table "pre_order", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "order_id", null: false
    t.string "amount", null: false
    t.string "payment_date", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "plan", null: false
    t.string "transaction_id", limit: 250, null: false
    t.integer "status", null: false
    t.integer "user_id", null: false
  end

  create_table "pre_order_backup", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "order_id", null: false
    t.string "amount", null: false
    t.string "payment_date", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "plan", null: false
    t.string "transaction_id", limit: 250, null: false
    t.integer "status", null: false
    t.integer "user_id", null: false
  end

  create_table "profile_page_queue_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "profile_page_id"
    t.bigint "queue_list_id"
    t.index ["profile_page_id"], name: "index_profile_page_queue_lists_on_profile_page_id"
    t.index ["queue_list_id"], name: "index_profile_page_queue_lists_on_queue_list_id"
  end

  create_table "profile_queue_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "profile_id"
    t.bigint "queue_list_id"
    t.index ["profile_id"], name: "index_profile_queue_lists_on_profile_id"
    t.index ["queue_list_id"], name: "index_profile_queue_lists_on_queue_list_id"
  end

  create_table "promotion_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "description"
    t.string "post_url"
    t.string "utc_offset"
    t.string "image"
    t.string "subimage1"
    t.string "subimage2"
    t.string "subimage3"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.date "start_date"
    t.date "end_date"
    t.index ["author_id"], name: "index_promotion_posts_on_author_id"
    t.index ["user_id"], name: "index_promotion_posts_on_user_id"
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", limit: 24
    t.string "logo"
    t.integer "property_images_count"
    t.bigint "agent_id"
    t.string "slug", null: false
    t.string "address2"
    t.string "country"
    t.integer "beds", default: 0
    t.integer "bath", default: 0
    t.integer "parking", default: 0
    t.boolean "is_rent", default: false
    t.integer "shares_count", default: 0
    t.integer "visits_count", default: 0
    t.index ["agent_id"], name: "index_properties_on_agent_id"
    t.index ["slug"], name: "index_properties_on_slug", unique: true
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "file"
    t.bigint "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_images_on_property_id"
  end

  create_table "queue_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "activity"
    t.string "image"
    t.date "started_on"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "queue_posts_count", default: 0
    t.date "ended_on"
    t.index ["user_id"], name: "index_queue_lists_on_user_id"
  end

  create_table "queue_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "description"
    t.string "post_url"
    t.string "utc_offset"
    t.string "queue_post"
    t.string "image"
    t.string "subimage1"
    t.string "subimage2"
    t.string "subimage3"
    t.bigint "queue_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "other_image_url"
    t.index ["queue_list_id"], name: "index_queue_posts_on_queue_list_id"
  end

  create_table "sent_for_approval", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "sender_user_id", null: false
    t.integer "sender_member_id", null: false
    t.integer "reciever_id", null: false
    t.string "post_id", limit: 50, null: false
    t.string "link_code", limit: 32, null: false
    t.integer "is_pending", null: false
  end

  create_table "sent_for_approval_links", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "link", null: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "test", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "data", limit: 50, null: false
    t.datetime "time", null: false
  end

  create_table "test_log", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.text "log", null: false
    t.string "date", limit: 20, null: false
  end

  create_table "tickets", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "name", limit: 150, null: false
    t.string "email", limit: 320, null: false
    t.string "site", limit: 150, null: false
    t.string "ticket", limit: 64, null: false
    t.string "subject", limit: 200, null: false
    t.text "msg", limit: 4294967295, null: false
    t.string "ip", limit: 150, null: false
    t.date "date", null: false
    t.time "time", null: false
    t.boolean "valid", null: false
    t.boolean "state", null: false
    t.date "cdate", null: false
    t.time "ctime", null: false
  end

  create_table "user", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "user_id", limit: 100, null: false
    t.string "email", limit: 60, null: false
    t.string "access_token", limit: 1000, null: false
  end

  create_table "wp_supsystic_ss_networks", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "class", null: false
    t.string "brand_primary", limit: 7, default: "#000000", null: false
    t.string "brand_secondary", limit: 7, default: "#ffffff", null: false
    t.integer "total_shares", default: 0, unsigned: true
  end

  create_table "wp_supsystic_ss_projects", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "settings", null: false
  end

  create_table "wp_users", primary_key: "ID", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
    t.string "user_login", limit: 60, default: "", null: false
    t.string "user_pass", default: "", null: false
    t.string "user_nicename", limit: 50, default: "", null: false
    t.string "user_email", limit: 100, default: "", null: false
    t.string "user_url", limit: 100, default: "", null: false
    t.datetime "user_registered", null: false
    t.string "user_activation_key", default: "", null: false
    t.integer "user_status", default: 0, null: false
    t.string "display_name", limit: 250, default: "", null: false
    t.index ["user_email"], name: "user_email"
    t.index ["user_login"], name: "user_login_key"
    t.index ["user_nicename"], name: "user_nicename"
  end

  create_table "yourl_log", primary_key: "click_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "click_time", null: false
    t.string "shorturl", limit: 200, null: false, collation: "latin1_bin"
    t.string "referrer", limit: 200, null: false
    t.string "user_agent", null: false
    t.string "ip_address", limit: 41, null: false
    t.string "country_code", limit: 2, null: false
    t.index ["shorturl"], name: "shorturl"
  end

  create_table "yourl_options", primary_key: ["option_id", "option_name"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "option_id", null: false, unsigned: true, auto_increment: true
    t.string "option_name", limit: 64, default: "", null: false
    t.text "option_value", limit: 4294967295, null: false
    t.index ["option_name"], name: "option_name"
  end

  create_table "yourl_url", primary_key: "keyword", id: :string, limit: 200, collation: "latin1_bin", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "url", null: false, collation: "latin1_bin"
    t.text "title", collation: "utf8_general_ci"
    t.timestamp "timestamp", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "ip", limit: 41, null: false
    t.integer "clicks", null: false, unsigned: true
    t.index ["ip"], name: "ip"
    t.index ["timestamp"], name: "timestamp"
  end

  create_table "youtube_channels", primary_key: "ytube_competitor", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "ytube_channelid", limit: 50, null: false
    t.string "ytube_channelname", limit: 75, null: false
    t.integer "ytube_compuserid", null: false
    t.datetime "ytube_createat", null: false
    t.integer "ytube_channel_status", limit: 1, null: false
    t.index ["ytube_channelid"], name: "ytube_channelid", unique: true
  end

  create_table "youtube_statistics", primary_key: "ytube_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "ytube_channelid", limit: 50, null: false
    t.string "ytube_videoid", limit: 40, null: false
    t.string "ytube_view", limit: 20, null: false
    t.string "ytube_like", limit: 20, null: false
    t.string "ytube_dislike", limit: 10, null: false
    t.string "ytube_favorite", limit: 15, null: false
    t.string "ytube_comment", limit: 15, null: false
    t.datetime "ytube_create_at", null: false
    t.string "ytube_status", limit: 6, null: false
  end

  add_foreign_key "enquiries", "agents"
  add_foreign_key "enquiries", "properties"
  add_foreign_key "facebook_ads", "facebook_connected_accounts"
  add_foreign_key "hq_office_mapping", "hq_users", column: "agent_user", name: "hq_office_mapping_ibfk_2", on_delete: :cascade
  add_foreign_key "hq_office_mapping", "hq_users", column: "office_user", name: "hq_office_mapping_ibfk_1", on_delete: :cascade
  add_foreign_key "hq_users", "offices"
  add_foreign_key "hq_users", "organisations"
  add_foreign_key "offices", "organisations"
  add_foreign_key "profile_page_queue_lists", "queue_lists"
  add_foreign_key "profile_queue_lists", "queue_lists"
  add_foreign_key "properties", "agents"
  add_foreign_key "property_images", "properties"
  add_foreign_key "queue_posts", "queue_lists"
end
