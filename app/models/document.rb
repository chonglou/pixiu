class Document < ActiveRecord::Base
  validates :name, uniqueness: {case_sensitive: false}
  validates_format_of :name, with: /\A[a-zA-Z][a-zA-Z0-9_]{1,32}\z/, on: :create
  validates :name, :title, :summary, :body, presence: true
end
