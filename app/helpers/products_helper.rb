module ProductsHelper
  def admin_products_right_nav_links
    [
        {url: edit_admin_product_url(@product), name: t('links.admin.product.info', id:@product.id)},
        {url: admin_product_spec_url(@product), name: t('links.admin.product.spec', id:@product.id)},
        {url: admin_product_pack_url(@product), name: t('links.admin.product.pack', id:@product.id)},
        {url: admin_product_service_url(@product), name: t('links.admin.product.service', id:@product.id)},
        {url: admin_product_samples_url(@product), name: t('links.admin.product.sample.index', id:@product.id)},
        {url: admin_product_tag_url(@product), name: t('links.admin.product.tag', id:@product.id)},
        {url: admin_product_status_url(@product), name: t('links.admin.product.status', id:@product.id)},
        {url: admin_product_prices_url(@product), name: t('links.admin.product.price.index', id:@product.id)},
    ]
  end
end