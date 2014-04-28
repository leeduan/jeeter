module ApplicationHelper
  def print_date(date_time)
    date_time.strftime("%B %d, %Y at %I:%M%P")
  end
end
