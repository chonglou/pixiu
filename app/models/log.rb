require 'elasticsearch/persistence/model'

class Log
  include Elasticsearch::Persistence::Model

  attribute :user, Integer
  attribute :content, String
  attribute :created, Time

  validates :content, :created, presence: true

end