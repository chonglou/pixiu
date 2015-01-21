require 'rss'
require 'builder'

class HomeController < ApplicationController
  include SharedHelper

  def index
  end

  def favicon
    icon = Setting.favicon
    if icon
      send_data icon.fetch(:data), type: icon.fetch(:type), disposition: 'inline'
    else
      render text: ''
    end
  end

  def google
    render 'google', layout: false
  end

  def baidu
    render 'baidu', layout: false
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
            Product.select(:uid, :lang, :updated_at).where('status <> ?', Product.statuses[:done]).order(id: :desc).each do |p|
              xm.url {
                xm.loc show_product_url(p.uid, locale: p.lang)
                xm.lastmod p.updated_at
              }
            end
            Document.select(:name, :lang, :updated_at).where('updated_at >= ? && updated_at< ?', time, time>>1).order(updated_at: :desc).each do |doc|
              xm.url {
                xm.loc show_document_url(doc.name, locale: doc.lang)
                xm.lastmod doc.updated_at
              }
            end
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
    lang = params[:locale]
    xml = Rails.cache.fetch("cache://public/rss_#{lang || 'all'}.xml", expires_in: 6.hours) do
      r = RSS::Maker.make('atom') do |maker|
        maker.channel.author = "no-reply@#{ENV['PIXIU_DOMAIN']}"
        maker.channel.updated = Time.now.to_s
        maker.channel.about = show_document_url('contact', locale: (lang||'zh-CN'))
        maker.channel.title = Setting["site_title_#{lang||'zh-CN'}"] || ' '

        insert_item = ->(link, title, description, updated) {
          maker.items.new_item do |item|
            item.link = link
            item.title = title
            item.description = html2text description
            item.updated = updated.to_s
          end
        }

        Product.select(
            :uid, :name, :lang, :summary, :updated_at).where(
            'status <> ?', Product.statuses[:done]).order(id: :desc).limit(
            20).each { |p| insert_item.call show_product_url(p.uid, locale: p.lang), p.name, md2html(p.summary), p.updated_at }

        # if lang
        #   Document.select(:name, :lang, :summary, :updated_at, :title).where(lang: lang).order(updated_at: :desc).limit(5).each { |doc| insert_item.call show_document_url(doc.name, locale: doc.lang), doc.title, md2html(doc.summary), doc.updated_at }        #
        # else
        #   Document.select(:name, :lang, :summary, :updated_at, :title).order(updated_at: :desc).limit(5).each { |doc| insert_item.call show_document_url(doc.name, locale: doc.lang), doc.title, md2html(doc.summary), doc.updated_at }
        # end

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
