class ApplicationController < ActionController::Base
  before_action :authorize!

protected

  def authorize!
    unless Authorization.new(self).permissable?
      head :unauthorized
    end
  end

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def doorkeeper_token
    return @token if instance_variable_defined?(:@token)
    methods = Doorkeeper.configuration.access_token_methods
    @token = Doorkeeper::OAuth::Token.authenticate request, *methods
  end

  def endpoint
    raise 'Endpoint is blank' if params[:endpoint].blank?
    Quill::API.endpoints[params[:endpoint]]
  end
end
