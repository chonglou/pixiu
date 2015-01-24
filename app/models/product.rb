class Product < ActiveRecord::Base
  after_create :add_counter
  before_create :add_uid

  before_destroy { |p| VisitCounter.find_by(flag: VisitCounter.flags[:product], key: p.id).destroy }

  validates :name, :summary, :details, presence: true

  has_many :samples
  has_many :prices
  has_and_belongs_to_many :carts
  has_and_belongs_to_many :tags

  enum status: {submit:1, publish: 5, expire:12, close: 10}


  def logo
    Sample.where(product_id: self.id, logo:true).first || Sample.where(product_id: self.id).first
  end

  private
  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:product], key:self.id
  end
  def add_uid
    self.uid = SecureRandom.uuid
  end
end
