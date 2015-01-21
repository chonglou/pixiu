class TagsController < ApplicationController
  def show
    @tag = Tag.find_by name: params[:name], lang: params[:locale]
    if @tag
      VisitCounter.find_by(flag: VisitCounter.flags[:tag], key: @tag.id).increment!(:count)
    else
      render_404
    end
  end
end