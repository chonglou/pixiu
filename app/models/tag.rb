class Tag < ActiveRecord::Base
  after_create :add_counter
  before_destroy {|t| VisitCounter.find_by( flag: VisitCounter.flags[:tag], key:t.name).destroy}
  validates :name, :lang, presence: true
  validates :name, uniqueness: {scope: :lang, case_sensitive: false}

  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:tag], key:self.name
  end
end
