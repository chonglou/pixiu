class Attachment < ActiveRecord::Base
  validates :user_id, :title, :content_type, :ext, presence: true

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  def image?
    self.content_type.start_with? 'image'
  end

  def read!(file)
    name = file.original_filename
    self.content_type = file.content_type
    self.title = name
    self.ext = name[name.rindex('.')+1, name.size].downcase
    self.avatar = file
  end
end
