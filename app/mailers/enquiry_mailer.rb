class EnquiryMailer < ApplicationMailer
	def send_enquiry(protocol, host, opt={})
		@user = opt
		@protocol = protocol
    @host = host
		mail(to: opt[:email], subject: 'Contact Enquiry')
	end


  def instagram_alert_email(post, profilable)
    @post_image = 'https://app.houseq.io' + post.legacy_capatable_image_url
    @post_url = post.post_url
    @post_text = post.ins_text_des
    @username = profilable.fname
    @post_scheduled_at = post.scheduled_at
    @post_scheduled_at_AUS_timezone = post.scheduled_at.in_time_zone('Australia/Adelaide')
    mail(to: 'hello@knackmap.com', subject: 'Instagram Posts Due in the Next 12 Hours')
  end
end