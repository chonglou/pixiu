class DocumentsController < ApplicationController
  layout 'document'

  def show
    lang=params[:locale]
    @document = Document.find_by name: params[:name], lang: lang
    if @document
      VisitCounter.find_by(flag: VisitCounter.flags[:document], key: @document.id).increment!(:count)
      @right_sidebars = [{
                             name: t('labels.recent_documents'),
                             links: Document.select(:name, :title, :lang).where(
                                 'id > ? AND lang = ?', @document.id-10, lang).order(
                                 updated_at: :desc).limit(20).map { |d| {
                                 name: d.title,
                                 url: show_document_path(d.name, locale: d.lang)}
                             }
                         }]
    else
      render_404
    end
  end
end