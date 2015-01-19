module SiteHelper
  def site_info(key)
    Setting["site_#{key}_#{request[:locale]}"]
  end

  def top_nav_links
    links = [
        {url: home_url, name: t('links.home.index')},
        {url: tags_url(flag: :product), name: t('links.product.tags.index')}
    ]

    sl = Setting.site_top_links
    links +=sl if sl

    if user_signed_in?
      links << {url: personal_url, name: t('links.personal.index')}
    end
    links << {url: documents_url, name: t('links.document.index')}
    links << {url: home_about_us_url, name: t('links.about_us')}

    links
  end
end
