class Admin::ProductController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_product!

  protected

  def _can_manage_product!
    need_role unless Ability.new(current_user).can?(:manage, :product)
  end

  def _fetch_product
    @product = Product.find params[:product_id]
  end
end