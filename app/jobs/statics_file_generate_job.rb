require 'rss'

class StaticsFileGenerateJob < ActiveJob::Base
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(*args)
    #---------------robots----------------
    Rails.logger.info 'Generate robots.txt'
    File.open "#{Rails.root}/public/robots.txt", 'w' do |f|
      f.puts 'User-agent: *'
      f.puts 'Disallow: /admin'
      f.puts "Sitemap: http://www.#{ENV['PIXIU_DOMAIN']}/sitemap.xml.gz"
    end

    #---------------sitemap----------------
    Rails.logger.info 'Generate sitemap.xml.gz'

    #---------------rss----------------
    Rails.logger.info 'Generate rss.xml'
    %w(zh-CN en).each do |lang|
      File.open("#{Rails.root}/public/rss-#{lang}.xml") do |f|

        rss = RSS::Maker.make('atom') do |maker|
          maker.channel.author = "no-reply@#{ENV['PIXIU_DOMAIN']}"
          maker.channel.updated = Time.now.to_s
          maker.channel.about = "https://www.#{ENV['PIXIU_DOMAIN']}/#{lang}/document/about"
          maker.channel.title = Setting["site_title_#{lang}"]

          maker.items.new_item do |item|
            item.link = "http://www.ruby-lang.org/en/news/2010/12/25/ruby-1-9-2-p136-is-released/"
            item.title = "Ruby 1.9.2-p136 is released"
            item.updated = Time.now.to_s
          end
        end
      end
    end


    #---------------google----------------
    Rails.logger.info 'Generate google verify'

    #---------------baidu----------------
    Rails.logger.info 'Generate baidu verify'

    #---------------http error----------------
    Rails.logger.info 'Generate http error html'
  end
end
