class Robinson < BaseScraper


  def css_selectors
    { final_price: ".js-sale-price", regular_price: ".js-original-price" }
  end

  def self.color
    "76ab37"
  end

  private

  def final_price
    @result.result[:final_price].delete('^0-9').to_i
  end

  def regular_price
    @result.result[:regular_price].delete('^0-9').to_i
  end
end
