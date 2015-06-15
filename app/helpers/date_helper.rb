module DateHelper
  def ldate(dt, hash = {})
    dt ? l(dt, hash) : nil
  end

  def date_format(date)
    return '' unless date.present?
    date.strftime('%d/%m/%Y')
  end

  def datetime_format(date)
    return '' unless date.present?
    date.strftime('%d/%m/%Y %H:%M')
  end
end
