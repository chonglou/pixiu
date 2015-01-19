

class StaticsFileGenerateJob < ActiveJob::Base
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(*args)
    #---------------robots----------------


    #---------------sitemap----------------
    Rails.logger.info 'Generate sitemap.xml.gz'

    #---------------rss----------------
    Rails.logger.info 'Generate rss.xml'
    %w(zh-CN en).each do |lang|
      File.open("#{Rails.root}/public/rss-#{lang}.xml") do |f|


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
