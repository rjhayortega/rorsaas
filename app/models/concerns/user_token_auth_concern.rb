# rgs pages url raw type page:belongs_to
module UserTokenAuthConcern
  extend ActiveSupport::Concern

  included do
    before_save :ensure_authentication_token
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def ensure_encrypted_password
    if encrypted_password.blank?
      pass = Base64.decode64(self.attributes['password']).gsub(/\-n4s$/, '')

      self.password = pass
      self.password_confirmation = pass
      self.save
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  module ClassMethods
  end
end