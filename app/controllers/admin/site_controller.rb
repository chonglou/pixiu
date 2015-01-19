class Admin::SiteController < ApplicationController
  layout 'dashboard'
  before_action :must_admin!
  def info
  end
end
