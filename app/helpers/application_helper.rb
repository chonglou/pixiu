

module ApplicationHelper
  def email2logo(email, size=nil)
    "http#{'s' if Rails.env.production?}://www.gravatar.com/avatar/#{Digest::MD5.hexdigest email.downcase}#{"?s=#{size}" if size}"
  end


  def filename2type(name)
    ext = File.extname(name)[1..-1]
    ext.downcase if ext
  end

end
