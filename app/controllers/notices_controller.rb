class NoticesController < ApplicationController
  layout 'document'

  def index
    lang=params[:locale]
    @notices = Notice.where(lang:lang).order(updated_at: :desc).limit(20)

    @right_sidebars = [{
                           name: t('labels.recent_documents'),
                           links: Document.select(:name, :title, :lang).where(lang:lang).order(
                               updated_at: :desc).limit(20).map { |d| {
                               name: d.title,
                               url: show_document_path(d.name, locale: d.lang)}
                           }
                       }]
  end
end
