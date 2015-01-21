class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :_set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:label, :email, :first_name, :middle_name, :last_name, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :label, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :middle_name, :last_name, :password, :password_confirmation, :current_password) }
  end

  def need_role
    flash[:alert] = t('labels.require_role')
    redirect_to root_path
  end

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  private
  def _set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
