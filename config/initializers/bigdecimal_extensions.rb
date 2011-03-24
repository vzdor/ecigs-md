BigDecimal.class_eval do
  def to_usd
    self / 12.0
  end
end
