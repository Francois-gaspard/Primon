class AddCalculatedPricesToScrapingResults < ActiveRecord::Migration[5.2]
  def change
    add_column :scraping_results, :prices, :jsonb, default: {}
  end
end
