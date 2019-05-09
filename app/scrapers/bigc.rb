class Bigc < BaseScraper


  def css_selectors
    { final_price: ".special-price .price", regular_price: "span.price" }
  end

  def self.color
    "b3d236"
  end

  private

  def final_price

    (@result.result[:final_price] || regular_price.to_s).delete('^0-9').to_i
  end

  def regular_price
    price = (@result.result[:regular_price] || @result.result[:final_price])&.delete('^0-9').to_i
    price == 0 ? nil : price
  end
end
