class Admin::PricesController < Admin::ProductController
  before_action :_fetch_product
  def index
  end
end
