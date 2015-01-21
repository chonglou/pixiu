class Document < ActiveRecord::Base
  after_create :add_counter
  before_destroy {|r| VisitCounter.find_by( flag: VisitCounter.flags[:document], key:r.name).destroy}

  validates :name, uniqueness: {scope: :lang, case_sensitive: false}
  validates_format_of :name, with: /[a-zA-Z0-9_]{1,32}\z/, on: :create
  validates :name, :title, :summary, :body, presence: true

  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:document], key:self.name
  end
end
