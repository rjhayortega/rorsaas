# == Schema Information
#
# Table name: post_tasks
#
#  id              :integer          not null, primary key
#  post_id         :integer
#  profilable_type :string(255)
#  profilable_id   :integer
#  result          :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deployed        :boolean          default(FALSE)
#

class PostTask < ApplicationRecord
  # Either a page or profile
  belongs_to :profilable, polymorphic: true
  belongs_to :post, counter_cache: true
  delegate :network, to: :profilable, allow_nil: true

  def external_url
    pid = if profilable.is_a?(Profile)
      profilable.profile_id
    elsif profilable.is_a?(ProfilePage)
      profilable.page_id
    end || ''

    case profilable&.network
    when 'twitter'
      if result
        "https://twitter.com/newsycombinator/status/" + result
      else
        "https://twitter.com/" + profilable.profile_id
      end
    when 'instagram'
      if result
        "https://instagram.com/" + profilable.fname
      else
        "https://instagram.com/" + profilable.fname
      end
    when 'facebook'
      if result
        splitted = result.match(/(\d+)_(\d+)/)
        "https://www.facebook.com/#{splitted[1]}/posts/#{splitted[2]}"
      else
        "https://www.facebook.com/" + pid
      end
    else
      "https://www.example.com/" + pid
    end
  end

  def run
    result = case profilable.network
    when 'twitter'
      TwitterService.new(post, profilable).run
    when 'linkedin'
      LinkedinService.new(post, profilable).run
    when 'facebook'
      FacebookService.new(post, profilable).run
    when 'instagram'

      EnquiryMailer.instagram_alert_email(post, profilable).deliver_now

      InstagramService.new(post, profilable).run
    else
      raise 'Unknown network'
    end

    self.update result: result, deployed: true
  end
end
