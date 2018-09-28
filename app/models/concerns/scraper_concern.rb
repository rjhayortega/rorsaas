# rgs pages url raw type page:belongs_to
module ScraperConcern
  extend ActiveSupport::Concern

  included do
  end

  def name
    url
  end

  def brief
    raw
  end

  def agent
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.56 (KHTML, like Gecko) Version/9.0 Safari/601.1.56'
  end

  def get_later force = false
    ScraperJob.perform_later self.class.name, url, force
  end

  def get cache = true
    resp = Typhoeus.get(url, headers: {"User-Agent" => agent}, followlocation: true)
    p url
    self.update raw: resp.body
    self
  end

  def doc
    @doc ||= Nokogiri::HTML self.raw
  end

  module ClassMethods
    def wipe url
      self.where(url: url).update raw: nil
    end

    def get url, force = false
      page = self.where(url: url).first_or_create
      page.get if page.raw.blank? || force
      page
    end

    def get_later url, force = false
      page = self.where(url: url).first_or_create
      page.get_later if page.raw.blank? || force
      page
    end
  end
end