class Notice < ActiveRecord::Base
  validates :lang, :content, presence: true
end
