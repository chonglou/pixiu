class Admin::PricesController < Admin::ProductController
  before_action :_fetch_product
  def new
    @price = Price.new
  end
  def create
    @price = Price.new _price_params
    @price.product_id = @product.id
    if @price.save
      redirect_to admin_product_prices_path
    else
      render 'new'
    end
  end
  def edit
    @price = Price.find params[:id]
  end
  def update
    @price = Price.find params[:id]
    if @price.update(_price_params)
      redirect_to admin_product_prices_path
    else
      render 'edit'
    end
  end
  def destroy
    Price.destroy params[:id]
    redirect_to admin_product_prices_path
  end
  private
  def _price_params
    params.require(:price).permit(:flag, :value)
  end
end
