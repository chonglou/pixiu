class Admin::TagsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_tag!

  def index
    @tags = Tag.select(:id, :name, :parent_id).where(lang: params[:locale]).page params[:page]
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
end
