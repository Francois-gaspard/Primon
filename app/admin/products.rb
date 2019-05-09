ActiveAdmin.register Product do
  permit_params :name, monitored_urls_attributes: [:id, :url]

  form do |f|
    inputs 'Details' do
      f.input :name
      f.has_many :monitored_urls, heading: 'URLs',
                 allow_destroy: true,
                 new_record: true do |a|
        a.input :url
      end
    end
    actions
  end

  # INDEX ------------------
   index do
     selectable_column
     column :name
     column(:last_change) { |p| "#{time_ago_in_words(p.last_change&.created_at&.iso8601 || 0)} ago" }
     column(:all_time_low) { |p| p.all_time_low&.final_price}
     column(:current_lowest) { |p| p.current_lowest&.final_price}
     actions
   end



  # SHOW -------------------

  show do

    render partial: "products/details", locals: { product: product }
    div class: 'custom-class' do
      h3 'Price per provider over time'

      render partial: 'metrics/providers_price_comparison_chart', locals: {metric: product.chart_provider_comparison, colors: product.chart_provider_comparison_colors}
    end

    panel 'Results' do
      table_for product.all_scraping_results, :row_class => -> record { 'cheapest' if record.all_time_low? } do
        column :domain_name
        column("Price") { |result| result&.regular_price }
        column("Discount") { |result| result&.discount }
        column("Discounted price") { |result| result&.final_price }
        column :different
        column :created_at
        column(:actions) { |result|
          [
            link_to("External", result.monitored_url.url, target: :blank),
            link_to("Monitored URL", admin_monitored_url_url(result.monitored_url_id))
          ].join(" ").html_safe
        }
      end
    end
    active_admin_comments
  end


end
