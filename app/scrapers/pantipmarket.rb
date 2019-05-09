class Pantipmarket < BaseScraper


  def css_selectors
    { regular_price: ".price" }
  end

  def self.color
    "FAAC58"
  end

  private

  def final_price
    @result.result[:regular_price].delete('^0-9').to_i
  end

  def regular_price
    @result.result[:regular_price].delete('^0-9').to_i
  end
end
