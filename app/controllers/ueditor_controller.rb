class UeditorController < ApplicationController
  def index
    case _get_action
      when 'config'
        rv={}
      else
        rv={}
    end
    render json: rv
  end

  private
  def _get_action
    Rack::Utils.parse_query(URI(request.url).query)['action']
  end
end
