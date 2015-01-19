module SiteHelper
  def site_info(key)
    Setting["site_#{key}_#{request[:locale]}"]
  end

  def top_nav_links
    links = [
        {url: home_url, name: t('links.home.index')}
    ]

    sl = Setting.site_top_links
    links +=sl if sl

    if user_signed_in?
      links << {url: edit_user_registration_path, name: t('links.personal.index')}
    end
    links << {url: document_url(id: 'help'), name: t('links.document.index')}
    links << {url: document_url(id: 'contact'), name: t('links.about_us')}

    links
  end
end
