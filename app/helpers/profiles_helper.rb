module ProfilesHelper
  def ensure_profile_image profile
    if profile.profile_image.present?
      profile.profile_image
    else
      case profile.network
      when 'linkedin'
        'https://static.licdn.com/scds/common/u/images/themes/katy/ghosts/company/ghost_company_120x80_v1.png'
      end
    end
  end
end
