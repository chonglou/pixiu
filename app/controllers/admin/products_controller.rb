class Admin::ProductsController < ApplicationController
  layout 'dashboard'
  before_action :_can_manage_product!

  def sample
    @product = Product.select().find params[:product_id]
    # todo
  end

  def service
    @product = Product.find params[:product_id]
    # todo
  end

  def pack
    @product = Product.find params[:product_id]
    # todo
  end

  def spec
    @product = Product.find params[:product_id]
    # todo
  end

  def price
    @product = Product.find params[:product_id]
    # todo
  end

  def status
    @product = Product.find params[:product_id]
    # todo
  end

  def tag
    @product = Product.find params[:product_id]
    case request.method
      when 'GET'
        @tree = Tag.get_root_tree(:product, @product.lang).fetch(:children)
        @ids = @product.tags.map { |t| "child-#{t.id}" }
      when 'POST'
        @product.tags.clear
        @product.tag_ids = params[:tags]
        render json: {ok: true}
      else
    end
  end

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
    @product.status = Product.statuses[:submit]
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
    @product = Product.find(params[:id])
    if @product.update _product_params
      redirect_to admin_products_path
    else
      render 'edit'
    end

  end

  def destroy
    p = Product.find params[:id]
    p.tags.clear
    p.destroy
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
