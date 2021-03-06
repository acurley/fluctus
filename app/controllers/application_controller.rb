class ApplicationController < ActionController::Base
  inherit_resources

  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym 
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller
   
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'blacklight'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   # If a User is denied access for an action, return them back to the last page they could view.
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "#{exception}"
    redirect_to root_path
  end
end
