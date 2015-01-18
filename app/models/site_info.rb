class SiteInfo
  def self.version!
    version_file = "#{Rails.root}/REVISION"
    if File.exist?(version_file)
      Setting.version = "#{File.open(version_file, 'r') { |f| f.read.strip }}-#{File.basename Rails.root}"
    end
  end

end
