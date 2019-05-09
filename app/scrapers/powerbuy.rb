class Powerbuy < BaseScraper

  def css_selectors
    { discounted_price: ".special-price", regular_price: ".save-price > .old-price", coupon: ".badge_purple", out_of_stock: ".note-out-of-stock" }
  end

  def self.color
    "83409e"
  end

  private

  def final_price
    price = @result.result[:discounted_price].delete('^0-9').to_i
    extra_discount = @result.result[:coupon].to_i
    price * (100 - extra_discount) / 100
  end

  def regular_price
    # Sometimes there is no discount. In that case, Powerbuy only shows the discounted price.
    (@result.result[:regular_price] || @result.result[:discounted_price]).delete('^0-9').to_i
  end
end
