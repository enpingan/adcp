class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    # redirect_to "http://my.cyberadvance.com" 
    # redirect_to "/admin"
    # session[:my_account] = current_user.my_account
    # profile_url
    dashboard_url
  end

  # before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :pwd, :email, :password)}
    # devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:login, :username, :pwd, :email, :password )}
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :passworwd, :current_password )}
  end



  # unless ActionController::Base.consider_all_requests_local
  #   rescue_from Exception, :with => :render_error
  #   rescue_from ActiveRecord::RecordNotfound, :with=>:render_not_found
  #   rescue_from ActionController::RoutingError, :with=>:render_not_found
  #   rescue_from ActionController::unknownController, :with=>:render_not_found
  #   rescue_from ActionController::unknownAction, :with=>:render_not_found
  # end

  # private

  # def render_not_found(exception)
  #   log_error(exception)
  #   render :template => '/error/404.html.erb', :status=>404
  # end

  # def render_error(exception)
  #   log_error(exception)
  #   render :template => '/error/500.html.erb', :status=>500
  # end

end
