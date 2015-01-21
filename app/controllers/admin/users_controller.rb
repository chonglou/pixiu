class Admin::UsersController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_site!

  def index
    @users = User.select(:id, :label, :email).order(last_sign_in_at: :desc).page params[:page]
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    unless @user.is_root?
      [:admin, :author, :seller, :assistant].each do |r|
        if params[r]
          @user.add_role r
        else
          @user.remove_role r
        end
      end
      flash[:notice]=t('labels.success')
      render 'edit'
    end
  end

  private
  def _can_manage_site!
    need_role unless Ability.new(current_user).can?(:manage, :site)
  end
end
