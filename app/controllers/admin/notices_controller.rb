class Admin::NoticesController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_notice!

  def index
    @notices = Notice.select(:id, :content, :updated_at).order(updated_at: :desc).where(lang: params[:locale]).page params[:page]
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new params.require(:notice).permit(:content)
    @notice.lang = params[:locale]
    if @notice.save
      redirect_to admin_notices_path
    else
      render 'new'
    end
  end

  def edit
    @notice = Notice.find params[:id]
  end

  def update
    @notice = Notice.find params[:id]
    @notice.update params.require(:notice).permit(:content)
    redirect_to admin_notices_path
  end

  def destroy
    Notice.destroy params[:id]
    redirect_to admin_notices_path
  end

  private
  def _can_manage_notice!
    need_role unless Ability.new(current_user).can?(:manage, :notice)
  end
end
