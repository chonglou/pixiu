class Attachment < ActiveRecord::Base
  validates :user_id, :title, :content_type, :ext, presence: true

  mount_uploader :avatar, AvatarUploader
end
