require "rake"

# Group consecutive results by result value, then ommit the first and last.
# Destroy remaining results from the db
# Eg with those made up results:
# 10, 30, 30, 30, 30, 20, 35, 35, 35, 40
# The goal is to keep those.
# 10, 30,         30, 20, 35,     35, 40
# I.e. get ride of identical intermediate values and only keep the limits

namespace :cleaner do
  desc "Removes identical consecutive scraping results"
  task run: [:environment] do
    urls               = MonitoredUrl.all.order("id")
    #urls   = [MonitoredUrl.find(22)]
    chunks = []
    urls.each do |url|
      all_results = url.scraping_results.order("id").to_a
      chunks      += split_by_result(all_results)
    end
    # Keep first and last of each chunk
    chunks.each do |chunk|
      chunk.pop
      chunk.shift
    end
    # and destroy everything else inbetween
    chunks.flatten.map(&:destroy)
  end
end

def split_by_result(all_results)
  chunks        = []
  last_result   = ""
  current_chunk = []
  all_results.each do |result|
    if last_result.blank? || last_result == result.normalized_result
      current_chunk << result
    else
      chunks << current_chunk
      current_chunk = [result]
    end
    last_result = result.normalized_result
  end
  chunks << current_chunk
  chunks
end
