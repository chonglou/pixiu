class Vendor < ActiveRecord::Base
  resourcify
  validates :name, :details, presence: true
end
