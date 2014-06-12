module ApplicationHelper
  def print_date(date_time)
    date_time.strftime("%B %-d, %Y at %-I:%M%P")
  end

  def print_list(obj_array, column)
    return '' if obj_array.empty?
    index = obj_array.size - 1
    list_conjunction = ''

    obj_array.each_with_index do |obj, i|
      value = obj[column.to_sym]
      list_conjunction += i == index ? value : "#{value}, "
    end
    list_conjunction
  end
end
