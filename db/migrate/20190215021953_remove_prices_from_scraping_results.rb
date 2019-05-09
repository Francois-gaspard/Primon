class RemovePricesFromScrapingResults < ActiveRecord::Migration[5.2]
  def change
    remove_column :scraping_results, :prices, :jsonb
  end
end
