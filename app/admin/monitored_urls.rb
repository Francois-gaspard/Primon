ActiveAdmin.register MonitoredUrl do
  permit_params :website, :url, :css_selector

  member_action :run, method: :post do
    resource.scrape
    redirect_to admin_monitored_urls_path, notice: "Scraping done!"
  end

  collection_action :run_all, method: :post do
    Thread.new {
      MonitoredUrl.all.each(&:scrape)
    }
    redirect_to collection_path, notice: "Scraping in progress! Check back soon."
  end

  action_item :add do
    link_to "Scrape all!", run_all_admin_monitored_urls_path, method: :post
  end

  batch_action :run_all do |ids|
    Thread.new {
    batch_action_collection.find(ids).each do |url|
       url.scrape
    end
    }
    redirect_to collection_path, alert: "Scraping in progress"
  end

  action_item :run, only: :show do
    link_to "Run now", run_admin_monitored_url_path(monitored_url), method: :post
  end

  # SHOW -------------------
  show title: proc {|url| "#{url.product.name} @ #{url.domain_name}"} do
    attributes_table do
      row :product
      row(:url) { |url| link_to url.url, url.url, target: :blank}
    end

    panel 'Results' do
      table_for monitored_url.scraping_results.order("created_at DESC"), :row_class => -> record { 'cheapest' if record.all_time_low_in_domain? } do
        column("Price") {|result| result.regular_price}
        column("Discount") {|result| result.discount}
        column("Discounted price") {|result| result.final_price}
        column("Result") {|result| result.result}
        column :different
        column :created_at
      end
    end
    div class: 'custom-class' do
      h3 'Price over time'

      render partial: 'metrics/price_chart', locals: {metric: monitored_url.chart_price_data}
    end
    active_admin_comments
  end

  # INDEX -------------------

  index do
    selectable_column
    column :product
    column :domain_name
    column :latest_price
    column :different_from_last
    column :last_scraped_at

    actions do |monitored_url|
      item "Run", run_admin_monitored_url_path(monitored_url), class: "member_link", method: :post
    end
  end
end

