class Attachment < ActiveRecord::Base
  validates :user_id, :title, :content_type, :ext, presence: true

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  def image?
    self.content_type.start_with? 'image'
  end
end
