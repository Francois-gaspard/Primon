require "rake"

namespace :scraper do
  desc "Check prices"
  task run: [:environment] do
    MonitoredUrl.all.each do |url|
      url.scrape
    end
  end
end
