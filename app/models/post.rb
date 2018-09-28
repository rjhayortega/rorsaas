# == Schema Information
#
# Table name: knack_post
#
#  id                       :integer          not null, primary key
#  title                    :string(50)
#  linkedin_title           :string(300)
#  description              :text(65535)
#  fb_text_des              :text(65535)
#  twit_text_des            :text(65535)
#  lin_text_des             :text(65535)
#  pin_text_des             :text(65535)
#  gp_text_des              :text(65535)
#  fb_description           :text(65535)
#  twitter_description      :text(65535)
#  link_description         :text(65535)
#  pin_description          :text(65535)
#  linkedin_description     :text(65535)
#  post_url                 :text(65535)
#  linkedin_url             :text(65535)
#  post_img                 :string(250)
#  album_images             :text(65535)
#  post_album               :string(255)
#  linkedin_image           :text(65535)
#  post_type                :string(100)
#  facebook                 :text(65535)
#  fb_status                :integer
#  fb_pages                 :text(65535)
#  fbpg_status              :integer
#  fb_groups                :text(65535)
#  fb_group_status          :integer
#  twitter                  :text(65535)
#  twitter_status           :integer
#  google_plus              :text(65535)
#  gplus_status             :integer
#  pinterest                :text(65535)
#  pinterest_status         :integer
#  pin_mail                 :integer          default(0)
#  linkedin                 :text(65535)
#  lin_status               :integer
#  lin_pages                :text(65535)
#  linpg_status             :integer
#  user_id                  :integer
#  schedule_date            :datetime
#  post_date                :date
#  origninal_scheduled_date :date
#  post_time                :string(250)
#  status                   :integer
#  status_draft_post        :integer
#  post_date_report         :string(50)
#  am_pm                    :string(10)
#  team_member_id           :integer
#  is_approved              :integer
#  reason                   :text(65535)
#  sentto                   :string(20)
#  category_name            :string(50)
#  category_bg              :string(20)
#  instagram                :text(65535)
#  instagram_status         :integer
#  instagram_description    :text(65535)
#  sched_id                 :string(20)
#  portfolio_id             :integer
#  houseq                   :string(10)
#  catid                    :integer
#  ins_text_des             :text(65535)
#  queue_list_id            :integer
#  scheduled_at             :datetime
#  utc_offset               :string(255)
#  created_at               :datetime
#  image                    :string(255)
#  subimage1                :string(255)
#  subimage2                :string(255)
#  subimage3                :string(255)
#  queue_post_id            :integer
#  updated_at               :datetime
#  deployed                 :boolean          default(FALSE)
#  post_tasks_count         :integer          default(0)
#  sub_img1                 :string(255)
#  sub_img2                 :string(255)
#  sub_img3                 :string(255)
#  timezone_str             :string(255)      default("UTC")
#  other_image_url          :string(255)
#

class Post < ApplicationRecord
  self.table_name = 'knack_post'

  belongs_to :user
  belongs_to :queue_list, optional: true
  belongs_to :queue_post, optional: true
  belongs_to :profilable, polymorphic: true, optional: true

  has_many :post_profiles, dependent: :destroy
  has_many :profiles, through: :post_profiles

  has_many :post_profile_pages, dependent: :destroy
  has_many :pages, through: :post_profile_pages, source: :profile_page

  has_many :post_tasks, dependent: :destroy

  after_create :create_tasks
  after_create :fill_post_img

  mount_uploader :image, ImageUploader
  mount_uploader :subimage1, ImageUploader
  mount_uploader :subimage2, ImageUploader
  mount_uploader :subimage3, ImageUploader

  scope :draft, -> { where(status_draft_post: 1) }

  def fill_post_img
    if post_img.include?('/uploads/tmp') && self.image.present?
      self.update post_img: self.image.url
    end

    if sub_img1.include?('/uploads/tmp') && self.subimage1.present?
      self.update sub_img1: self.subimage1.url
    end
    if sub_img2.include?('/uploads/tmp') && self.subimage3.present?
      self.update sub_img2: self.subimage2.url
    end
    if sub_img3.include?('/uploads/tmp') && self.subimage3.present?
      self.update sub_img3: self.subimage3.url
    end
  end

  def legacy_capatable_image_url
    url = if image.present?
      
            image.url
            
          elsif post_img.include?('upload_files/discover_')
            "https://app.knackmap.com/#{post_img}"
          elsif post_img.present?
            if post_img.include?('://')
              post_img
            else
              "https://app.houseq.io/upload_files/post/#{post_img}"
            end
          end

        if url.present?
            URI.escape url
        else
          ''
        end
  end

  def legacy_capatable_subimage1_url
     subimage1_url = if subimage1.present?
          sub_img1
          elsif sub_img1.include?('upload_files/discover_')
            "https://app.knackmap.com/#{post_img}"
          elsif sub_img1.present?
            if sub_img1.include?('://')
              sub_img1
            else
              "https://app.houseq.io/upload_files/post/#{post_img}"
            end
          end

        if subimage1_url.present?
            URI.escape subimage1_url
        else
          ''
        end
  end
  def legacy_capatable_subimage2_url
     subimage2_url = if subimage2.present?
          sub_img2
          elsif sub_img2.include?('upload_files/discover_')
            "https://app.knackmap.com/#{post_img}"
          elsif sub_img2.present?
            if sub_img2.include?('://')
              sub_img2
            else
              "https://app.houseq.io/upload_files/post/#{post_img}"
            end
          end
  
        if subimage2_url.present?
            URI.escape subimage2_url
        else
          ''
        end
  end

  def legacy_capatable_subimage3_url
     subimage3_url = if subimage3.present?
          sub_img3
          elsif sub_img3.include?('upload_files/discover_')
            "https://app.knackmap.com/#{post_img}"
          elsif sub_img3.present?
            if sub_img3.include?('://')
              sub_img3
            else
              "https://app.houseq.io/upload_files/post/#{post_img}"
            end
          end

        if subimage3_url.present?
            URI.escape subimage3_url
        else
          ''
        end
  end

  def legacy_capatable_image_url_thumb
    url = if image.thumb.present?
      
              image.thumb.url
            
          elsif post_img.include?('upload_files/discover_')
            "https://app.knackmap.com/#{post_img}"
          elsif post_img.present?
            if post_img.include?('://')
              post_img
            else
              "https://app.houseq.io/upload_files/post/#{post_img}"
            end
          end

          if url.present?
            URI.escape url
          else
            ''
          end

  end

  def legacy_capatable_post_type
    
    return 'image' if self.image.present?
    return 'image' if self.post_img.present?
    return 'image' if self.subimage1.present?
    return 'image' if self.subimage2.present?
    return 'image' if self.subimage3.present?
    return 'link' if self.post_url.present?
    return 'text'
  end

  def legacy_capatable_text
    description
  end

  def self.notify_php_scheduler
    Typhoeus.get "http://app.houseq.io/schedule_post.php"
  end


  def fill_user_utc_offset
    # binding.pry
    offset = Time.current.localtime(self.utc_offset).utc_offset
    timezone = ActiveSupport::TimeZone.all.select{|tz| tz.utc_offset == offset}.first

    if timezone
      timezone_name = timezone.tzinfo.name

      self.user.update(timezone: timezone_name) if self.user.timezone != timezone_name
    end
  end

  def self.deploy_create_post_tasks_from_old_post
    # Post.where("schedule_date > ?", 5.days.ago).where(scheduled_at: nil).find_each do |post|
    Post.where(scheduled_at: nil).find_each do |post|
    # Post.find_each do |post|
      begin
        post.migrate_from_old
      rescue
      end
    end
  end

  def migrate_from_old
    # scheduled_at
    # self.update(scheduled_at: self.schedule_date - (9.5).hours)
    self.update(scheduled_at: self.schedule_date)

    # created_at and utc_offset
    time_str = "#{self.origninal_scheduled_date} #{self.post_time.gsub('.', ':').upcase} +0000"

    if self.origninal_scheduled_date
      
      created_at = Time.strptime(time_str, "%Y-%m-%d %H:%M %z").in_time_zone
      diff = (created_at - scheduled_at)/60/60

      signs = diff > 0 ? '+' : '-'
      mins = (diff%1 * 60).to_i
      hours = diff.to_i
      if hours < 10
        hours = '0' + hours.to_s
      end

      self.update(
        created_at: created_at,
        utc_offset: "#{signs}#{hours}:#{mins}",
      )
    end
  end

  def create_tasks
    PostTask.where(post_id: self.id).destroy_all
    PostProfile.where(post_id: self.id).destroy_all
    PostProfilePage.where(post_id: self.id).destroy_all

    profile_ids = Profile.where(user_id: self.user_id, network: 'facebook', profile_id: self.facebook.split(',')).map(&:id) +
      Profile.where(user_id: self.user_id, network: 'twitter', profile_id: self.twitter.split(',')).map(&:id) +
      Profile.where(user_id: self.user_id, network: 'linkedin', profile_id: self.linkedin.split(',')).map(&:id) +
      Profile.where(user_id: self.user_id, network: 'instagram', fname: self.instagram.split(',')).map(&:id)

    page_ids = ProfilePage.where(user_id: self.user_id, network: 'facebook', page_id: self.fb_pages.split(',')).map(&:id) +
      ProfilePage.where(user_id: self.user_id, network: 'linkedin', page_id: self.lin_pages.split(',')).map(&:id)

    profile_ids.map do |pid|
      PostProfile.where(post_id: self.id, knack_profiles_id: pid).first_or_create
    end

    page_ids.map do |pid|
      PostProfilePage.where(post_id: self.id, knack_pages_id: pid).first_or_create
    end

    self.profiles.each do |profile|
      task = self.post_tasks.where(profilable: profile).first_or_create
    end

    self.pages.each do |page|
      task = self.post_tasks.where(profilable: page).first_or_create
    end
  end

  def is_draft?
    status_draft_post == 1
  end

  # def send_mail_instagram

  #   self.update 
    
  # end

  def deploy!
    self.update deployed: true
    self.create_tasks
    self.post_tasks.each do |task|
      # TaskRunnerJob.new.perform( task.id )
      # TaskRunnerJob.perform_at( self.scheduled_at, task.id )
      TaskRunnerJob.set(wait_until: self.scheduled_at).perform_later(task.id)
    end
  end

  def fill_garbage
    
    fb_profiles = self.profiles.select { |prof| prof.network == 'facebook' }.map(&:profile_id).join(',')
    fb_pages = self.pages.select { |prof| prof.network == 'facebook' }.map(&:page_id).join(',')

    linkedin_profiles = self.profiles.select { |prof| prof.network == 'linkedin' }.map(&:profile_id).join(',')
    linkedin_pages = self.pages.select { |prof| prof.network == 'linkedin' }.map(&:page_id).join(',')

    twitter_profiles = self.profiles.select { |prof| prof.network == 'twitter' }.map(&:profile_id).join(',')

    # self.scheduled_at ||= 1.minutes.ago
    # self.scheduled_at ||= Time.now.utc + 2.seconds
    if self.scheduled_at.present?
      # self.scheduled_at = Time.zone
      self.scheduled_at = self.scheduled_at.strftime("%Y-%m-%d %H:%M:%S").in_time_zone(self.timezone_str)
    else
      self.scheduled_at = Time.now.utc + 2.seconds
    end
    # self.utc_offset = self.utc_offset.presence || "+03:20"
    self.post_img = self&.image&.url || ''
    self.sub_img1 = self.subimage1.url || ''
    self.sub_img2 = self.subimage2.url || ''
    self.sub_img3 = self.subimage3.url || ''

    self.post_url ||= ''
    self.post_type  = if self.post_img.present?
      'image'
    elsif self.post_url.present?
      'link'
    else 
      'text'
    end
    # 0 = Publish Now, 1 = Scheduled. I guess they are always the same
    self.fb_status ||= 0
    self.fb_group_status ||= 0
    self.fbpg_status ||= 0
    self.twitter_status ||= 0
    self.gplus_status ||= 0
    self.pinterest_status ||= 0
    self.lin_status ||= 0
    self.linpg_status ||= 0
    self.instagram_status ||= 0
    self.status_draft_post ||= 0
    self.instagram ||= ''
    self.status ||= 0

    data = {
      title: '',
      linkedin_title: '',

      description: self.description,
      fb_text_des: self.description,
      twit_text_des: self.description,
      lin_text_des: self.description,
      pin_text_des: self.description,
      gp_text_des: self.description,
      ins_text_des: self.description,
      fb_description: self.description,
      twitter_description: self.description,
      link_description: self.description,
      pin_description: self.description,
      linkedin_description: self.description,

      linkedin_url: '',
      album_images: '',
      post_album: '',
      linkedin_image: '',

      facebook: fb_profiles,
      fb_pages: fb_pages,
      fb_groups: '',

      twitter: twitter_profiles,

      google_plus: '',

      pinterest: '',
      pin_mail: 0,

      linkedin: linkedin_profiles,
      lin_pages: linkedin_pages,

      user_id: self.user_id,
      schedule_date: self.scheduled_at,
      post_date: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%Y-%m-%d"),
      # post_date: self.scheduled_at.localtime(self.utc_offset).utc.strftime("%Y-%m-%d"),
      
      origninal_scheduled_date: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%Y-%m-%d"),
      # origninal_scheduled_date: self.scheduled_at.localtime(self.utc_offset).utc.strftime("%Y-%m-%d"),
      post_time: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%H.%M %P"),
      # post_time: self.scheduled_at.localtime(self.utc_offset).utc.strftime("%H.%M %P"),
      post_date_report: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%H.%M"),
      # post_date_report: self.scheduled_at.localtime(self.utc_offset).utc.strftime("%H.%M"),
      am_pm: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%P"),
      # am_pm: self.scheduled_at.localtime(self.utc_offset).utc.strftime("%P"),
      team_member_id: 0,
      is_approved: 0,
      reason: '',
      sentto: '',
      category_name: '',
      category_bg: '',
      instagram_description: self.description,
      sched_id: 0,
      portfolio_id: 0,
      houseq: '',
      # idea_post: '',
      catid: 0,
      # user_made: 1,
    }

    self.attributes = data
  end

  def deploy_to_old
    fb_profiles = self.profiles.select { |prof| prof.network == 'facebook' }.map(&:profile_id).join(',')
    fb_pages = self.pages.select { |prof| prof.network == 'facebook' }.map(&:page_id).join(',')
    # fb_groups = self.pages.select { |prof| prof.network == 'facebook' }.map(&:profile_id).join(',')

    linkedin_profiles = self.profiles.select { |prof| prof.network == 'linkedin' }.map(&:profile_id).join(',')
    linkedin_pages = self.pages.select { |prof| prof.network == 'linkedin' }.map(&:page_id).join(',')

    twitter_profiles = self.profiles.select { |prof| prof.network == 'twitter' }.map(&:profile_id).join(',')

    if self.scheduled_at.present?
      # self.scheduled_at = Time.zone
      self.scheduled_at = self.scheduled_at.strftime("%Y-%m-%d %H:%M:%S").in_time_zone(self.timezone_str)
    else
      self.scheduled_at = Time.now.utc + 2.seconds
    end

    data = {
      title: '',
      linkedin_title: '',

      description: self.content,
      fb_text_des: self.content,
      twit_text_des: self.content,
      lin_text_des: self.content,
      pin_text_des: self.content,
      gp_text_des: self.content,
      ins_text_des: self.content,
      fb_description: self.content,
      twitter_description: self.content,
      link_description: self.content,
      pin_description: self.content,
      linkedin_description: self.content,

      post_url: '',
      linkedin_url: '',
      post_img: '',
      album_images: '',
      post_album: '',
      linkedin_image: '',
      post_type: self.image.present? ? 'image' : 'text',

      facebook: fb_profiles,
      fb_pages: fb_pages,
      fb_groups: '',

      twitter: twitter_profiles,

      google_plus: '',

      pinterest: '',
      pin_mail: 0,

      linkedin: linkedin_profiles,
      lin_pages: linkedin_pages,

      # 0 = Publish Now, 1 = Scheduled. I guess they are always the same
      fb_status: 0,
      fb_group_status: 0,
      fbpg_status: 0,
      twitter_status: 0,
      gplus_status: 0,
      pinterest_status: 0,
      lin_status: 0,
      linpg_status: 0,
      instagram_status: 0,

      status: 0,
      status_draft_post: 0,

      user_id: self.user_id,
      # schedule_date: self.scheduled_at  + (9.5).hours,
      schedule_date: self.scheduled_at,
      post_date: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%Y-%m-%d"),
      origninal_scheduled_date: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%Y-%m-%d"),
      post_time: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%H.%M %P"),

      post_date_report: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%H.%M"),
      am_pm: self.scheduled_at.in_time_zone(self.timezone_str).strftime("%P"),

      team_member_id: 0,
      is_approved: 0,
      reason: '',
      sentto: '',
      category_name: '',
      category_bg: '',
      instagram: '',
      instagram_description: self.content,
      sched_id: 0,
      portfolio_id: 0,
      houseq: '',
      idea_post: '',
      catid: 0,
      user_made: 1,
    }
    
    self.update knack_post: Post.create(data)
  end
end
