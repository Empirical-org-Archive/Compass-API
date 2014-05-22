class ApiController < ApplicationController
  before_action :find_object, only: [:show, :update, :destroy]
  before_action :authorize!

  rescue_from ActionController::RoutingError do
    render json: { error_message: 'The resource you were looking for does not exist' }, status: 404
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    Raven.capture_exception(e)
    render json: { error_message: 'The resource you were looking for does not exist with the given ID' }, status: 404
  end

  def index
    render text: '', head: :ok
  end

  def show
    singleton_response
  end

  def update
    permitted_params = []

    endpoint.attributes.each do |attr, val|
      if val.is_a? Hash
        permitted_params << { attr => params[attr].try(:keys) || [] }
      else
        permitted_params << attr
      end
    end

    @object.attributes = params.permit(*permitted_params)

    if @object.save
      singleton_response
    else
      render json: { error: @object.errors }
    end
  end

  def create
    @object = scope.new
    @object.set_owner(current_user) if @object.ownable?
    update
  end

protected

  def singleton_response
    methods = endpoint.attributes.keys
    render json: { object: @object.as_json(root: false, only: [], methods: (methods << 'uid')) }
  end

  def find_object
    if endpoint.options.try(:[], 'singular')
      @object = scope.new(self)
    else
      @object = scope.find_by_uid!(params[:id])
    end
  end

  def scope
    @scope ||= params[:endpoint].singularize.camelize.constantize
  end

private

  def authorize!
    print 'Bearer'
    puts env['HTTP_AUTHORIZATION']

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

  # rescue_from(Exception) do |e|
  #   binding.pry
  #   render json: { error_message: "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly." }, status: 500
  # end
end
