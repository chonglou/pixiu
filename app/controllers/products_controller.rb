class ProductsController < ApplicationController
  def show
    @product = Product.where('uid = ? AND lang = ? AND status <> ?', params[:uid], params[:locale], Product.statuses[:done]).limit(1)
    if @product
      VisitCounter.find_by(flag: VisitCounter.flags[:product], key: @product.uid).increment!(:count)
    else
      render_404
    end
  end
end
