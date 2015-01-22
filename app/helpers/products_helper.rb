module ProductsHelper
  def admin_products_right_nav_links
    [
        {url: edit_admin_product_url(@product), name: t('links.admin.product.info', id:@product.id)},

        {url: admin_product_tag_url(@product), name: t('links.admin.product.tag', id:@product.id)},
        {url: admin_product_status_url(@product), name: t('links.admin.product.status', id:@product.id)},
        {url: admin_product_price_url(@product), name: t('links.admin.product.price', id:@product.id)},
    ]
  end
end