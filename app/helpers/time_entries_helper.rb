module TimeEntriesHelper
  
  def format_time(timeElapsed) 
    seconds = timeElapsed % 60
    minutes = (timeElapsed / 60) % 60
    hours = (timeElapsed / 3600)

    "%d:%02d:%02d" % [hours, minutes,seconds]
  end

  def format_datetime(datetime)
    datetime.try(:strftime, "%d/%m/%y %H:%M")
  end
end
