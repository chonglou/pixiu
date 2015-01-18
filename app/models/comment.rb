class Comment < ActiveRecord::Base
  validates :user_id, :uid, :project_uid, :content, :order_id, :star, presence: true
end
