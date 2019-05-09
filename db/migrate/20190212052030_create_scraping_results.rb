class CreateScrapingResults < ActiveRecord::Migration[5.2]
  def change
    create_table :scraping_results do |t|
      t.references :monitored_url, foreign_key: true
      t.jsonb :result
      t.boolean :different

      t.timestamps
    end
  end
end
