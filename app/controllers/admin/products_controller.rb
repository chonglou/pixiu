class Admin::ProductsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_product!

  def index
    @products = Product.select(:uid, :name, :name, :summary, :updated_at).order(updated_at: :desc).where(lang: params[:locale]).page params[:page]
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new _product_params
    @product.lang = params[:locale]
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    @product.update _product_params
    redirect_to admin_products_path
  end

  def destroy
    Product.destroy params[:id]
    redirect_to admin_products_path
  end

  private
  def _product_params
    params.require(:product).permit(:name, :summary, :details)
  end

  def _can_manage_product!
    need_role unless Ability.new(current_user).can?(:manage, :product)
  end
end
