class Notice < ActiveRecord::Base
  paginates_per 50
  validates :lang, :content, presence: true
end
