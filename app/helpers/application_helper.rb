module ApplicationHelper
  def latest_backgrounds
    [
        'data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==',
        'data:image/gif;base64,R0lGODlhAQABAIAAAGZmZgAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==',
        'data:image/gif;base64,R0lGODlhAQABAIAAAFVVVQAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=='
    ]
  end
  def email2logo(email, size=nil)
    "http#{'s' if Rails.env.production?}://www.gravatar.com/avatar/#{Digest::MD5.hexdigest email.downcase}#{"?s=#{size}" if size}"
  end


  def filename2type(name)
    ext = File.extname(name)[1..-1]
    ext.downcase if ext
  end

end
