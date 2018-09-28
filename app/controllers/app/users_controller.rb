class App::UsersController < ApplicationController
  def index
    User.where(authentication_token: nil).map(&:save)
    head :ok
  end
end
