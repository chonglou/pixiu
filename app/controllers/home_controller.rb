require 'rss'
require 'builder'

class HomeController < ApplicationController
  def index
  end

  def sitemap
    xmlns='http://www.sitemaps.org/schemas/sitemap/0.9'
    start = Setting.init
    stop = 0.seconds.ago.to_date

    if params[:year] && params[:month]
      time = DateTime.new(params[:year].to_i, params[:month].to_i, 1)
      if time >= (start.to_date << 1) && time <= stop
        xml = Rails.cache.fetch("cache://public/sitemap-#{time.to_date}.xml", expires_in: 24.hours) do
          target = ''
          xm = Builder::XmlMarkup.new(target: target)
          xm.instruct!
          xm.urlset(xmlns: xmlns) {
            Document.select(:name, :updated_at).where('updated_at >= ? && updated_at< ?', time, time>>1).each do |doc|
              xml.url {
                xml.loc document_path(locale: nil, id: doc.name)
                xml.lastmod doc.updated_at
              }
            end
            # todo 其它
          }
          target
        end
      else
        xml = Rails.cache.fetch('cache://public/sitemap-null.xml', expires_in: 10.years) do
          target = ''
          xm = Builder::XmlMarkup.new(target: target)
          xm.instruct!
          xm.urlset(xmlns: xmlns)
          target
        end
      end
      xml
    else
      xml = Rails.cache.fetch('cache://public/sitemap.xml', expires_in: 24.hours) do
        target = ''
        xm = Builder::XmlMarkup.new(target: target)
        xm.instruct!
        xm.sitemapindex(xmlns: xmlns) {
          xm.sitemap {
            xm.loc sitemap_url(year: stop.year, month: stop.month, locale: nil)
            xm.lastmod stop
          }
          i = 1
          time = i.month.ago.to_date.end_of_month
          while time > start
            xm.sitemap {
              xm.loc sitemap_url(year: time.year, month: time.month, locale: nil)
              xm.lastmod i.month.ago.to_date.end_of_month
            }
            i+=1
            time = i.month.ago.to_date.end_of_month
          end
        }
        target
      end
    end


    render xml: xml
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
          Document.select(:name, :updated_at, :title).where(lang: lang).limit(5).each { |doc| insert_item.call documents_url(id: doc.name), doc.title, doc.updated_at }
          #todo 其它
        else
          Document.select(:name, :updated_at, :title).limit(5).each { |doc| insert_item.call documents_url(id: doc.name), doc.title, doc.updated_at }
          #todo 其它
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
Sitemap: http://www.#{ENV['PIXIU_DOMAIN']}/sitemap.xml
STR
    end
    render text: txt
  end
end
