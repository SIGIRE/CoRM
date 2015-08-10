# encoding: utf-8

Time::DATE_FORMATS[:humanized]  = ->(time) do
  st = Time.now.beginning_of_day
  nd = Time.now.end_of_day

  case
  when time.between?(st + 1.day, nd + 1.day)
    "Demain à #{time.strftime('%H:%M')}"
  when time.between?(st, nd)
    "Aujourd'hui à #{time.strftime('%H:%M')}"
  when time.between?(st - 1.day, nd - 1.day)
    "Hier à #{time.strftime('%H:%M')}"
  else
    time.strftime('%d/%m/%y à %H:%M')
  end
end
