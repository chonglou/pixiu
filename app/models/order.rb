class Order < ActiveRecord::Base
  validates :user_id, :uid, presence: true
  enum statuses: [:submit, :pay, :progress, :packaged, :delivered, :done]
end
