class Admin::ProductsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_product!

  def index
    @products = Product.select(
        :id, :uid, :name, :name, :summary, :created_at).order(id: :desc).where(
        'lang = ? AND status <> ?',
        params[:locale],
        Product.statuses[:done]).page params[:page]
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.new _product_params
    @product.lang = params[:locale]
    @product.uid = SecureRandom.uuid
    @product.status = Product.statuses[:submit]
    @product.version = 1
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
    op = Product.find(params[:id])
    @product = Product.new _product_params
    @product.uid = op.uid
    @product.version = op.version+1
    @product.status = op.status
    if @product.save
      op.update status: Product.statuses[:done]
      redirect_to admin_products_path
    else
      render 'edit'
    end

  end

  def destroy
    p = Product.find params[:id]
    p.update status: Product.statuses[:done]
    VisitCounter.find_by( flag: VisitCounter.flags[:product], key:p.uid).destroy
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
