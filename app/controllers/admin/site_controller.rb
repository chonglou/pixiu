class Admin::SiteController < ApplicationController
  layout 'dashboard'
  before_action :must_admin!
  before_action :_set_nav_links

  def status
    @mysql=ActiveRecord::Base.connection.execute('SHOW STATUS').inject({}) { |rs, (k, v)| rs[k]=v; rs }
  end

  def info
  end

  private
  def _set_nav_links
    @right_nav_links = [
        {url: admin_site_status_url, name: t('links.admin.site.status.title')},
        {url: admin_site_info_url, name: t('links.admin.site.info')},

    ]
  end

end
