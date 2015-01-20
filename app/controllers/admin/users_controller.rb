class Admin::UsersController < ApplicationController
  layout 'dashboard'
  before_action :must_admin!

  def index
    @users = User.select(:id, :label, :email).order(last_sign_in_at: :desc).page params[:page]
  end

  def edit
    @user = User.find params[:id]
  end
  def update
    @user = User.find params[:id]
    unless @user.is_root?
      [:admin,:author,:seller,:assistant].each do |r|
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
end
