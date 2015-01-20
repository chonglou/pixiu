class DocumentsController < ApplicationController
  layout 'document'

  def show
    @document = Document.find_by name: params[:name]
    @right_sidebars = [{
        name: t('labels.recent_documents'),
        links: Document.select(
            :name,
            :title,
            :lang).where(
            'id > ? AND id < ?',
            @document.id-6,
            @document.id+6).map { |d| {
              name: d.title,
              url: show_document_path(d.name, locale: d.lang)}
        }
    }]
  end
end