class AddProductIdToMonitoredUrls < ActiveRecord::Migration[5.2]
  def change
    add_reference :monitored_urls, :product, foreign_key: true
  end
end
