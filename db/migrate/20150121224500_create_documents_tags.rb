class CreateDocumentsTags < ActiveRecord::Migration
  def change
    create_table :documents_tags, id:false do |t|
      t.belongs_to :document, index:true, null:false
      t.belongs_to :tag, index:true, null:false
    end
  end
end
