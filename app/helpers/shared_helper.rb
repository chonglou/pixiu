require 'redcarpet'
require 'nokogiri'

module SharedHelper
  MARKDOWN=Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(link_attributes:{target:'_blank'}), tables: true)
  def md2html(md)
    MARKDOWN.render md
  end
  def html2text(html)
    Nokogiri::HTML(html).text
  end
end