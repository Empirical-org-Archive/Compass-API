class ApplicationController < ActionController::Base
  doorkeeper_for :all

protected

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
