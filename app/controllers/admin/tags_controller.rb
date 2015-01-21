class Admin::TagsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_tag!

  def index
    respond_to do |format|
      format.json do
        render json: [_tree(:product), _tree(:document)]
      end
      format.html do
        render 'index'
      end
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new params.require(:tag).permit(:name)
    @tag.lang = params[:locale]
    if @tag.save
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find params[:id]
  end

  def update
    @tag = Tag.find params[:id]
    @tag.update params.require(:tag).permit(:name)
    redirect_to admin_tags_path
  end

  def destroy
    Tag.destroy params[:id]
    redirect_to admin_tags_path
  end

  private
  def _can_manage_tag!
    need_role unless Ability.new(current_user).can?(:manage, :tag)
  end

  def _tree(flag)
    children = Tag.select(:id, :name).where('lang = ? AND flag = ? AND parent_id IS NULL', params[:locale], Tag.flags[flag]).order(id: :asc).map do |t1|
      {id: t1.id, text: t1.name}
    end
    {
        id: flag,
        text: t("models.#{flag}"),
        children: children,
        state: {opened: true},
        icon: 'glyphicon glyphicon-home'
    }
  end
end
