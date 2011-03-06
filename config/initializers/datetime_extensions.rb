
module DatetimeExtensions
  def short
    self.strftime("%y/%m/%d %H:%M")
  end

  def short_date
    self.strftime("%y/%m/%d")
  end

  def short_time
    self.strftime("%H:%M")
  end
end

Time.send(:include, DatetimeExtensions)
