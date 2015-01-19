class Admin::SiteController < ApplicationController
  layout 'dashboard'
  before_action :must_admin!
  before_action :_set_nav_links

  def clear
    #%w(robots.txt sitemap.xml.gz en/rss.xml zh-CN/rss.xml).each {|n| Rails.cache.delete "cache://public/#{n}"}
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
        %w(name title keywords description copyright).each { |k| Setting["site_#{k}_#{request[:locale]}"] = params[k.to_sym] }
        render 'info'
      else
    end
  end

  private
  def _set_nav_links
    @right_nav_links = [
        {url: admin_site_status_url, name: t('links.admin.site.status.title')},
        {url: admin_site_info_url, name: t('links.admin.site.info')},

    ]
  end

end
