class ProductPresenter < BasePresenter

  def all_time_high_price
    "#{super} THB"
  end

  def all_time_low_price
    "#{super} THB"
  end

  def providers
    monitored_urls.map {|url| h.link_to url.domain_name, url.url, target: :blank}.to_sentence.html_safe
  end

  def current_lowest
    "#{super&.final_price} THB"
  end

  def last_change
    "#{h.time_ago_in_words(super&.created_at || 0)} ago"
  end


end
