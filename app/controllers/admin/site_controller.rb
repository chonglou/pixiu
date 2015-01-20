class Admin::SiteController < ApplicationController
  layout 'dashboard'
  before_action :must_admin!

  def google
    Setting.google_code = params[:code]
    redirect_to admin_site_seo_path
  end

  def baidu
    Setting.baidu_code = params[:code]
    redirect_to admin_site_seo_path
  end

  def favicon
    Setting.favicon = params[:url]
    redirect_to admin_site_seo_path
  end

  def clear
    Rails.cache.clear
    flash[:notice] = t('labels.success')
    redirect_to admin_site_status_path
  end

  def status
    @mysql=ActiveRecord::Base.connection.execute('SHOW STATUS').inject({}) { |rs, (k, v)| rs[k]=v; rs }
  end

  def info
    case request.method
      when 'GET'
      when 'POST'
        %w(name title keywords description copyright).each { |k| Setting[_setting_key(k)] = params[k.to_sym] }
        render 'info'
      else
    end
  end

  private

  def _setting_key(k)
    "site_#{k}_#{request[:locale]}"
  end

end
