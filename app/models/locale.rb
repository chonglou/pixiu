class Locale < ActiveRecord::Base
  validates :lang, :flag, :uid, :tid, presence: true
  enum flags: [:notice, :product]
end
