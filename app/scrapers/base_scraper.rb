require 'open-uri'

class BaseScraper

  def initialize(monitored_url)
    @monitored_url = monitored_url
    @result = @monitored_url.scraping_results.new(result: {})
  end

  def scrape
    # Load the page
    page = Nokogiri::HTML(open(@monitored_url.uri))

    # Extract relevant data
    css_selectors.each do |name, selector|
      @result.result[name] = page.css(selector).first&.text
    end

    # Parse relevant data
    calculate_prices

    # Compare prices to see if there is a difference
    @result.different = price_change?

    @result.save

    if @result.all_time_low? && @result.different?
      UserMailer.new.discount_email(@result)
    end

    # do this last so we dont mess up comparison before
    destroy_previous_result if destroy_previous_result?

  rescue OpenURI::HTTPError, Net::OpenTimeout => e
    UserMailer.new.scraping_error_email(monitored_url: @monitored_url, message: e.message)
  end

  def self.color
    "333333"
  end

  private

  def calculate_prices
    @result.regular_price = regular_price
    @result.discount = (regular_price - final_price) if regular_price && final_price
    @result.final_price = final_price
  end

  def price_change?
    return false if previous.blank?
    [@result.regular_price.to_i, @result.discount.to_i, @result.final_price.to_i] != [previous.regular_price.to_i, previous.discount.to_i, previous.final_price.to_i]
  end

  def previous_results
    @previous_results ||= @monitored_url.scraping_results.order("created_at asc").last(2)
  end

  def previous
    @previous ||= previous_results[1]
  end

  def three_ago
    @three_ago ||= previous_results[0]
  end

  def destroy_previous_result?
    return false unless previous.present? && three_ago.present?
    @result.normalized_result == previous.normalized_result &&
      previous.normalized_result == three_ago.normalized_result
  end

  def destroy_previous_result
    previous.destroy
  end


end
