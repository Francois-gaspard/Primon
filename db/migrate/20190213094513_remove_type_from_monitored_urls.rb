class RemoveTypeFromMonitoredUrls < ActiveRecord::Migration[5.2]
  def change
    remove_column :monitored_urls, :type, :string
  end
end
