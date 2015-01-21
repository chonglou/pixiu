class Locale < ActiveRecord::Base
  validates :lang, :flag, :uid, :tid, presence: true
  enum flags: {notice:1, product:2}
end
