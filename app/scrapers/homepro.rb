class Homepro < BaseScraper


  def css_selectors
    { final_price: "h4.price", regular_price: ".original-price", savings: ".savings strong" }
  end

  private

  # Note that Homepro adds some hidden discount when adding to cart. These are not included in the scraping.
  def final_price
    return if @result.result[:final_price].blank?
    (@result.result[:final_price]&.delete('^0-9').to_i/100) - savings
  end

  def regular_price
    # Homepro puts the regular price in the final price when there is no discount
    return final_price if @result.result[:regular_price].blank?
    @result.result[:regular_price]&.delete('^0-9').to_i/100
  end

  def self.color
    "0066b3"
  end

  private

  def savings
    @result.result[:savings]&.delete('^0-9').to_i/100
  end
end
