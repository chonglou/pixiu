

class StaticsFileGenerateJob < ActiveJob::Base
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(*args)
  end
end
