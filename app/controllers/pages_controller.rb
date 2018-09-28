class PagesController < ApplicationController
  def index
  end

  def get_account_limit
    if current_user.profiles.count < current_user.account_limit
      tf = true
    else
      tf = false
    end
    render json: {pronum: current_user.account_limit, tf: tf}
  end
end
