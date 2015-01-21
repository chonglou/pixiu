module DocumentsHelper
  def admin_documents_right_nav_links
    [
        {url: edit_admin_document_url(@document), name: t('links.admin.document.info', id:@document.id)},

        {url: admin_document_tag_url(@document), name: t('links.admin.document.tag', id:@document.id)},
    ]
  end
end