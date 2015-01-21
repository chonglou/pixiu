class Tag < ActiveRecord::Base
  after_create :add_counter
  before_destroy {|t| VisitCounter.find_by( flag: VisitCounter.flags[:tag], key:t.id).destroy}

  validates :name, :lang, :flag, presence: true
  #validates :name, uniqueness: {scope: [:lang, :flag], case_sensitive: false}
  enum flag: {product: 1, document: 2}

  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:tag], key:self.id
  end
end
