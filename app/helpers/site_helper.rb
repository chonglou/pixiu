module SiteHelper
  def site_info(key)
    Setting["site_#{key}_#{request[:locale]}"]
  end

  def top_nav_links
    links = [
        {url: root_url, name: t('links.home.index')}
    ]

    sl = Setting.site_top_links
    links +=sl if sl

    if user_signed_in?
      links << {url: edit_user_registration_path, name: t('links.personal.index')}
    end
    links << {url: show_document_url('help'), name: t('links.document.help')}
    links << {url: show_document_url('contact'), name: t('links.document.contact')}

    links
  end

  def admin_site_right_nav_links
    [
        {url: admin_site_status_url, name: t('links.admin.site.status.title')},
        {url: admin_site_info_url, name: t('links.admin.site.info')},
        {url: admin_site_seo_url, name: t('links.admin.site.seo.title')},
        {url: admin_users_url, name: t('links.admin.user.index')},
    ]
  end
end
