class Boonthavorn < BaseScraper


  def css_selectors
    { final_price: ".product-shop > .price-info > .price-box > .special-price > .price", regular_price: ".old-price" }
  end

  def self.color
    "CC0000"
  end

  private

  def final_price
    @result.result[:final_price].delete('^0-9').to_i
  end

  def regular_price
    @result.result[:regular_price].delete('^0-9').to_i
  end
end
