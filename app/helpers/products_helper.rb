module ProductsHelper

  def latest_products
    latest_items=[]
    Product.where(latest: true).order(updated_at: :desc).each do |p|
      logo = p.background
      if logo
        latest_items << {
            img: logo,
            url: show_product_by_uid_path(p.uid),
            title: p.name,
            summary: md2html(p.summary)
        }
      end
    end
    if latest_items.empty?
      1.upto(3) do |i|
        latest_items << {
            img: latest_backgrounds.sample,
            url: '#',
            title: "Page #{i}",
            summary: "<p>Summary #{i}</p>"
        }

      end
    end
    latest_items
  end

  def hot_products
    hot_items=[]
    Product.where(hot: true).order(updated_at: :desc).map do |p|
      logo = p.logo
      if logo
        hot_items << {
            img: logo,
            url: show_product_by_uid_path(p.uid),
            title: p.name,
            summary: md2html(p.summary)
        }
      end
    end

    if hot_items.empty?
      1.upto(5) do |i|
        hot_items << {
            url: '#',
            title: "Product #{i}",
            summary: "<p>Details #{i}</p>"
        }
      end
    end
    puts '#'*20, hot_items.to_json, '#'*20
    hot_items.each_with_index { |f, i| puts '#'*5, f, i }
    hot_items
  end

  def admin_products_right_nav_links
    [
        {url: edit_admin_product_url(@product), name: t('links.admin.product.info', id: @product.id)},
        {url: admin_product_spec_url(@product), name: t('links.admin.product.spec', id: @product.id)},
        {url: admin_product_pack_url(@product), name: t('links.admin.product.pack', id: @product.id)},
        {url: admin_product_service_url(@product), name: t('links.admin.product.service', id: @product.id)},
        {url: admin_product_samples_url(@product), name: t('links.admin.product.sample.index', id: @product.id)},
        {url: admin_product_tag_url(@product), name: t('links.admin.product.tag', id: @product.id)},
        {url: admin_product_status_url(@product), name: t('links.admin.product.status', id: @product.id)},
        {url: admin_product_prices_url(@product), name: t('links.admin.product.price.index', id: @product.id)},
    ]
  end

  def admin_product_price_flag_select_options
    Price.flags.map { |k, v| [t("helpers.label.price.flag_#{k}"), v] }
  end

end