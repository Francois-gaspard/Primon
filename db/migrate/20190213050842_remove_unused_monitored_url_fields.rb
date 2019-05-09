class RemoveUnusedMonitoredUrlFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :monitored_urls, :website, :string
    remove_column :monitored_urls, :css_selector, :string
  end
end
