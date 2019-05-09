class AddPricesToScrapingResults < ActiveRecord::Migration[5.2]
  def change
    add_column :scraping_results, :regular_price, :decimal
    add_column :scraping_results, :discount, :decimal
    add_column :scraping_results, :final_price, :decimal
  end
end
