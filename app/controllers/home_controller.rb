require 'rss'

class HomeController < ApplicationController
  def index
  end

  def rss
    lang=params[:locale]
    xml = Rails.cache.fetch("cache://public/rss_#{lang || 'all'}.xml", expires_in: 6.hours) do
      r = RSS::Maker.make('atom') do |maker|
        maker.channel.author = "no-reply@#{ENV['PIXIU_DOMAIN']}"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = document_url(id: 'about_us', locale: (lang||'zh-CN'))
        maker.channel.title = Setting["site_title_#{lang||'zh-CN'}"] || ' '

        insert_item = ->(link, title, updated) {
          maker.items.new_item do |item|
            item.link = link
            item.title = title
            item.updated = updated
          end
        }

        if lang
          Document.select(:name, :updated_at, :title).where(lang: lang).each {|doc| insert_item.call documents_url(id: doc.name), doc.title, doc.updated_at}
        else
          Document.select(:name, :updated_at, :title).all.each {|doc| insert_item.call documents_url(id: doc.name), doc.title, doc.updated_at}
        end

      end
      r.to_s
    end
    render xml: xml
  end

  def robots
    txt = Rails.cache.fetch('cache://public/robots.txt', expires_in: 24.hours) do
      <<STR
User-agent: *
Disallow: /admin
Sitemap: http://www.#{ENV['PIXIU_DOMAIN']}/sitemap.xml.gz
STR
    end
    render text: txt
  end
end
