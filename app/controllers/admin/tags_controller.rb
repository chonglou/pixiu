class Admin::TagsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_tag!

  def index
    lang =  params[:locale]
    respond_to do |format|
      format.json do
        render json: [Tag.get_root_tree(:product,lang), Tag.get_root_tree(:document, lang)]
      end
      format.html do
        render 'index'
      end
    end
  end


  def create
    @tag = Tag.new params.permit(:name, :parent_id)
    if params[:flag]
      @tag.flag = Tag.flags[params[:flag].to_sym]
    else
      @tag.flag = Tag.find(params[:parent_id]).flag
    end
    @tag.lang = params[:locale]
    if @tag.save
      render json: {ok: true, id: @tag.id}
    else
      render json: {ok: false, reason: t('labels.input_not_valid')}
    end
  end

  def update
    @tag = Tag.find params[:id]
    if @tag.update params.permit(:name)
      render json: {ok: true}
    else
      render json: {ok: false, reason: t('labels.input_not_valid')}
    end
  end

  def destroy
    if Tag.where(parent_id: params[:id]).count == 0
      Tag.destroy params[:id]
      render json: {ok: true}
    else
      render json: {ok: false, reason: t('labels.in_using')}
    end
  end

  private
  def _can_manage_tag!
    need_role unless Ability.new(current_user).can?(:manage, :tag)
  end

  # def _root_tree(flag)
  #   children = Tag.select(:id, :name).where(
  #       'lang = ? AND flag = ? AND parent_id IS NULL',
  #       params[:locale], Tag.flags[flag]).order(id: :asc).map {|t|_node_tree t}
  #
  #   {
  #       id: "root_#{flag}",
  #       text: t("models.#{flag}"),
  #       type: 'folder',
  #       children: children,
  #       state: {opened: true},
  #       icon: 'glyphicon glyphicon-home'
  #   }
  # end
  #
  # def _node_tree(tag)
  #   children = Tag.select(:id, :name).where(parent_id:tag.id).order(id: :asc).map{|tag| _node_tree tag}
  #   {
  #       id: tag.id,
  #       text: tag.name,
  #       type: 'folder',
  #       state: {opened: true},
  #       children: children,
  #       #icon: 'glyphicon glyphicon-folder-open'
  #   }
  # end
end
