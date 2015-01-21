class Order < ActiveRecord::Base
  validates :user_id, :uid, presence: true
  enum statuses: {submit:0, pay:5, progress:10, packaged:15, delivered:20, done:100}
end
