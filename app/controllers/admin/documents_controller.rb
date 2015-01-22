class Admin::DocumentsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_document!

  def tag
    @document = Document.find params[:document_id]
    case request.method
      when 'GET'
        @tree = Tag.get_root_tree(:document, @document.lang).fetch(:children)
        @ids = @document.tags.map { |t| t.id }
      when 'POST'
        @document.tag_ids = params[:tags]
        render json: {ok: true}
      else
    end
  end

  def index
    @documents = Document.select(:id, :name, :title, :summary, :updated_at).order(updated_at: :desc).where(lang: params[:locale]).page params[:page]
  end


  def new
    @document = Document.new
  end

  def create
    @document = Document.new _document_params
    @document.lang = params[:locale]
    if @document.save
      redirect_to admin_documents_path
    else
      render 'new'
    end
  end

  def edit
    @document = Document.find params[:id]
  end

  def update
    @document = Document.find params[:id]
    if @document.update _document_params
      redirect_to admin_documents_path
    else
      render 'edit'
    end
  end

  def destroy
    Document.destroy params[:id]
    redirect_to admin_documents_path
  end

  private
  def _document_params
    params.require(:document).permit(:name, :title, :summary, :body)
  end

  def _can_manage_document!
    need_role unless Ability.new(current_user).can?(:manage, :document)
  end
end
