class CreateMonitoredUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :monitored_urls do |t|
      t.string :url
      t.string :website
      t.string :css_selector

      t.timestamps
    end
  end
end
