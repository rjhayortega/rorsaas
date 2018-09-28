class MailchimpService
  def self.campaigns options = {}
    url = "https://us10.api.mailchimp.com/3.0/campaigns"
    json = JSON.parse(Typhoeus.get(url, params: {
      sort_field: 'send_time',
      sort_dir: 'DESC',
      status: 'sent',
      count: 50
    }.merge(options), userpwd: 'hsu:d383220aade2d234f8a1cdaf078e53cf-us10').body)
    json['campaigns']
  end
end