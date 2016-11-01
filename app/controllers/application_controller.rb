class ApplicationController < ActionController::Base
  NotAuthenticatedError = Class.new(StandardError)

  attr_reader :current_user
  
  rescue_from Mongoid::Errors::DocumentNotFound do
    render_error 'Resource not found', status: :not_found
  end

  rescue_from NotAuthenticatedError do
    render_error 'Not authenticated', status:	:unauthorized
  end

  protected
  
  def render_error(message, options = {})
    render options.merge(json:{ error: message })
  end
  
  def render_validation_errors(errors)
    render json: { validation_errors: errors.messages }
  end
  
  def authenticate!
    authenticate_or_request_with_http_token do |token, _options|
      begin
        @current_user = User.find_by(token: token)
      rescue Mongoid::Errors::DocumentNotFound
        raise NotAuthenticatedError
      end
    end
  end
end
