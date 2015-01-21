class Product < ActiveRecord::Base
  after_create :add_counter

  validates :uid, uniqueness: {scope: :version}
  validates :uid, :name, :summary, :details, presence: true

  has_many :prices
  has_and_belongs_to_many :carts

  enum status: {submit:1, publish: 5, close: 10, done:100}

  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:product], key:self.uid
  end
end
