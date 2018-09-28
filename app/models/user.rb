# == Schema Information
#
# Table name: hq_users
#
#  id                       :integer          not null, primary key
#  first_name               :string(250)
#  last_name                :string(250)
#  email                    :string(250)
#  user_type                :string(17)
#  note                     :text(65535)
#  password                 :string(250)
#  address                  :text(65535)
#  phone                    :string(250)
#  country                  :string(250)
#  state                    :string(250)
#  city                     :string(250)
#  job_title                :string(250)
#  company                  :string(250)
#  time_zone                :string(250)
#  business_name            :string(250)
#  assigning_tasks          :string(250)
#  task_notification_emails :string(250)
#  fb_audience_confirmation :string(250)
#  fb_photo_upload          :string(250)
#  profile_picture          :string(250)
#  status                   :integer          default(0)
#  fb_connect               :integer
#  fb_id                    :string(300)
#  access_token             :string(500)
#  long_live_token          :string(500)
#  twitter_connect          :integer
#  twitter_id               :string(300)
#  google_connect           :integer
#  google_id                :string(300)
#  linkedin_connect         :integer
#  linkedin_id              :string(300)
#  youtube_connect          :integer
#  youtube_id               :string(250)
#  date                     :date
#  invite                   :integer
#  response                 :integer
#  login_time               :datetime
#  paid                     :integer
#  online                   :integer
#  auto_report              :string(200)
#  report_sent_count        :integer
#  report_sent_date         :date
#  report_send_date         :date
#  current_plan             :string(200)
#  plan_id                  :string(20)
#  plan_amount              :string(200)
#  expiry_date              :date
#  expiry_notification_date :date
#  purchase_date            :date
#  last_login               :datetime
#  login_location           :string(500)
#  registered_date          :date
#  payment_reminder_date    :date
#  beta                     :integer
#  cancel                   :integer
#  extended_until           :string(50)
#  username                 :string(55)
#  Joeycrowd                :integer
#  email_verify             :string(100)
#  account_limit            :integer
#  encrypted_password       :string(255)      default("")
#  reset_password_token     :string(255)
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  authentication_token     :string(255)
#  timezone                 :string(255)
#  organisation_id          :integer
#  office_id                :integer
#  stripe_customer_id       :string(255)
#  is_new_design            :boolean          default(TRUE)
#  bio                      :string(255)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable,
        :omniauthable, omniauth_providers: [:facebook]

  self.table_name = 'hq_users'
  include UserTokenAuthConcern
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_inclusion_of :timezone, in: ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:name), allow_nil: true

  validates :first_name, :last_name, :phone, presence: true

  has_many :profiles
  has_many :folders
  has_many :profile_pages, -> { where.not(page_type: 'business_page') }
  has_many :posts
  has_many :properties
  has_many :agents
  has_many :enquiries

  has_many :ideas

  has_many :stripe_customers
  has_many :stripe_subscriptions

  has_many :queue_lists, dependent: :destroy
  has_many :queue_posts, through: :queue_lists

  belongs_to :organisation, optional: true, counter_cache: true
  belongs_to :office, optional: true, counter_cache: true
  has_many :facebook_connected_accounts, dependent: :destroy
  has_many :facebook_ads, dependent: :destroy, through: :facebook_connected_accounts

  has_many :promotion_posts
  has_many :created_promotion_posts, foreign_key: :author_id, class_name: "PromotionPost"

  after_create :set_default_fields
  mount_uploader :profile_picture, ImageUploader

 def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end



  def name
    [first_name, last_name].join(' ')
  end

  def offices
    if is_organisation_admin?
      organisation.offices.includes(:users)
    else
      [self.office]
    end
  end

  def collegues
    if is_organisation_admin?
      organisation.users.where.not(id: id)
    else
      office.users.where.not(id: id)
    end
  end

  # validates :email, :user_type, :password, :password_confirmation, presence: true
  # validates :email, :password, :password_confirmation, presence: true

  validates :email, presence: true

  def collegue_office_managers
  end

  def collegue_admins
  end

  def collegue_agents
  end

  def is_web_admin?
    email.in? %w(houseq.1up@0sg.net josh@knackmap.com) || email.downcase.include?('dolly')
  end

  def is_organisation_admin?
    user_type == 'Premium Account'
  end

  def is_office_admin?
    user_type == 'Office Account'
  end

  def is_super_admin?
    email.in? %w(houseq.1up@0sg.net josh@knackmap.com) || email.downcase.include?('dolly')
  end

  def plan_name
    case self.plan_id
    when 'FREE'
      return 'FREE PLAN'

    when 'hq_sd_plan', 'hq_sd_plan_10'
      return 'STANDARD PLAN'

    when 'hq_plus_plan'
      return 'PLUS PLAN'

    when 'hq_office_plan'
      return 'OFFICE PLAN'
    else
      self.plan_id
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def load_missing_knack_posts
    fb_ids = self.profiles.where(network: 'facebook').pluck(:id)
    fb_page_ids = self.profile_pages.where(network: 'facebook').pluck(:id)
    twitter_ids = self.profiles.where(network: 'twitter').pluck(:id)
    linkedin_ids = self.profiles.where(network: 'linkedin').pluck(:id)
    linkedin_page_ids = self.profile_pages.where(network: 'linkedin').pluck(:id)

    existing_ids = Post.pluck(:knack_post_id)
    # Post.where('schedule_date > ?', DateTime.current + 9.5.hours).where.not(id: existing_ids).each do |kp|
    Post.where('schedule_date > ?', DateTime.current.utc ).where.not(id: existing_ids).each do |kp|

      data = {
        title: kp.title,
        content: kp.fb_text_des,
        # scheduled_at: kp.schedule_date - (9.5).hours,
        scheduled_at: kp.schedule_date.utc,
        utc_offset: '+00:00',
        knack_post_id: kp.id,
        is_draft: false,
        user_id: 1140,
      }

      data[:post_type] = case kp.post_type
        when 'image'
          'image/png'
        when 'link'
          if kp.post_img.present?
            'image/png'
          else
            'text/txt'
          end
        when 'video'
          'video/mp4'
        else
          'text/txt'
        end

      data[:page_ids] = self.profile_page_ids
      data[:profile_ids] = self.profile_ids  - fb_ids

      data[:page_ids] = data[:page_ids] - fb_page_ids if kp.fb_pages.blank?
      data[:page_ids] = data[:page_ids] - linkedin_page_ids if kp.lin_pages.blank?
      data[:profile_ids] = data[:profile_ids] - twitter_ids if kp.twitter.blank?
      data[:profile_ids] = data[:profile_ids] - linkedin_ids if kp.linkedin.blank?

      if kp.post_img.present?
        data[:image] = if kp.post_img.include?('http')
          kp.post_img
        else
          'https://d3k126rs1o10en.cloudfront.net/upload_files/post/' + kp.post_img
        end
      end

      post = Post.create(data)
    end
  end

 	private

 	def set_default_fields
 		update_columns 	user_type: 'Interest Account', paid: 0, plan_id: 'FREE', plan_amount: 0, status: 1, account_limit: 8, email_verify: Digest::MD5.hexdigest(Time.now.to_s), registered_date: Time.now.strftime("%Y/%m/%d"), expiry_notification_date: Date.today.next_month - 3.days, expiry_date: Date.today.next_month
 	end
end
