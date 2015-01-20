class Document < ActiveRecord::Base
  validates :name, uniqueness: {scope: :lang, case_sensitive: false}
  validates_format_of :name, with: /[a-zA-Z0-9_]{1,32}\z/, on: :create
  validates :name, :title, :summary, :body, presence: true
end
