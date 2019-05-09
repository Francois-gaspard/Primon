class AddTypeToMonitoredUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :monitored_urls, :type, :string
  end
end
