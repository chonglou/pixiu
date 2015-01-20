class AttachmentsController < ApplicationController
  def index
    case _get_action
      when 'config'
        render text: File.open("#{Rails.root}/config/ueditor.json", 'r') { |f| f.read.gsub /\/\*[\s\S]+?\*\//, '' }
      else
        render json: {}
    end
  end

  def upload
    if current_user

    end
  end

  private
  def _get_action
    Rack::Utils.parse_query(URI(request.url).query)['action']
  end
end
