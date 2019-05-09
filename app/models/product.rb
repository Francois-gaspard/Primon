class Product < ApplicationRecord
  has_many :monitored_urls, dependent: :destroy
  has_many :scraping_results, through: :monitored_urls


  accepts_nested_attributes_for :monitored_urls

  def all_scraping_results
    scraping_results.order("created_at desc")
  end

  def all_time_low
    scraping_results.order("final_price asc").first
  end

  def all_time_high
    scraping_results.order("final_price desc").first
  end

  def all_time_low_price
    all_time_low&.final_price
  end

  def all_time_high_price
    all_time_high&.final_price
  end

  def last_change
    all_scraping_results.where(different: true).first
  end

  def current_lowest
    latest = latest_scraping_results
    latest.any? ? latest.min_by(&:final_price) : nil
  end

  def latest_scraping_results
    monitored_urls.map(&:latest_scraping_result).delete_if{ |result| result&.final_price.nil? }
  end

  def chart_provider_comparison
    monitored_urls.map do |url|
      { name: url.domain_name, data: url.scraping_results.map { |result| [result&.created_at.iso8601, result&.final_price] } }
    end
  end

  def chart_provider_comparison_colors
    monitored_urls.map(&:color)
  end
end
