class MonitoredUrl < ApplicationRecord
  AVAILABLE_SCRAPERS = [Homepro, Bigc, Powerbuy, Pantipmarket, Boonthavorn, Robinson]

  belongs_to :product
  has_many :scraping_results, dependent: :destroy
  has_one :latest_scraping_result, -> { order created_at: :desc }, class_name: "ScrapingResult", foreign_key: :monitored_url_id

  def all_time_low
    scraping_results.order("final_price asc").first
  end

  def scrape
    scraper.new(self).scrape
  end

  def latest_result
    scraping_results.last
  end

  def latest_price
    latest_result&.final_price if latest_result.present?
  end

  def last_scraped_at
    latest_result&.created_at
  end

  def different_from_last
    scraping_results.last(2).map{ |sr| [sr.regular_price, sr.discount, sr.final_price]}.uniq.length != 1
  end

  def domain_name
    uri.host.downcase
  end

  def display_name
    "#{product.name}@#{domain_name}"
  end

  def uri
    begin
      URI.parse(url)
    rescue URI::InvalidURIError
      URI.parse(URI.escape(url))
    end
  end

  def scraper
    potential_scraper = uri.to_s.split(".")[1].capitalize.constantize
    potential_scraper if potential_scraper.in?(AVAILABLE_SCRAPERS)
  end

  def color
    scraper.color
  end

  def chart_price_data
    final_price_data = { name: "Discounted price", data: scraping_results.map { |result| [result.created_at.iso8601, result.final_price] } }
    discount_data = { name: "Discount", data: scraping_results.map { |result| [result.created_at.iso8601, result.discount] } }
    [final_price_data, discount_data]
  end
end
