module ApplicationHelper
  def date(date)
    return l(date, format: "%d %b %Y")
  end

  def datetime(datetime)
    return l(datetime, format: "%d %b %Y - %H:%m")
  end
end