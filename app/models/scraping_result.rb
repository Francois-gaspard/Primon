class ScrapingResult < ApplicationRecord
  belongs_to :monitored_url
  has_one :product, through: :monitored_url
  delegate :domain_name, to: :monitored_url

  def all_time_low?
     final_price == product.all_time_low.final_price
  end

  def all_time_low_in_domain?
    final_price == monitored_url.all_time_low.final_price
  end

  def normalized_result
    result.sort.to_s.gsub(" ", "")
  end
end
