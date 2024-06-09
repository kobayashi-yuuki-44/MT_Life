module DiariesHelper
  def icon_for_diaries(count)
    case count
    when 1
      '📙'
    when 2
      '📙📘'
    when 3
      '📙📘📕'
    else
      ''
    end
  end

  def icon_for_diary(index, total)
    case total
    when 1
      '📙'
    when 2
      index == 0 ? '📘' : '📙'
    when 3
      index == 0 ? '📕' : index == 1 ? '📘' : '📙'
    else
      ''
    end
  end
end
