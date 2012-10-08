Countdown = (options) ->
  instance = {}
  interval = 0
  timer= 0
  endTime= Math.floor(new Date( options.endTime || "Wed Oct 31 2012 15:00:00" ).getTime()/1000)

  onUpdateStatus = () ->
    days = Math.floor(timer / (60*60*24))
    remainder = timer % (60*60*24)
    
    hours = Math.floor(remainder / (60*60))
    remainder = remainder % (60*60)
    
    minutes = Math.floor(remainder / 60)
    remainder = remainder % 60
    
    seconds = remainder
    
    if minutes < 10
      minutes = "0" + minutes
   
    if seconds < 10
      seconds = "0" + seconds
    
    if days == 1  
      day_s = " day "
    else
      day_s = " days "
      
    $("#timer").text("Time Left: " + days + day_s + hours + ":" + minutes + ":" + seconds)
    return
    
  onCounterEnd = () ->
    $("#timer").html("<strong>SOLD!!<strong>").css("color", "lightgreen")
    return
  
  updateStatus = options.onUpdateStatus || onUpdateStatus
  counterEnd = options.onCounterEnd || onCounterEnd  

  instance.start = () ->
    clearInterval(interval)
    timer = Math.floor(endTime - new Date().getTime()/1000)
    decrementCounter()
    interval = setInterval(decrementCounter, 1000)
    return


  instance.stop = () ->
    clearInterval(interval)
    return
    
  decrementCounter = () ->
    if (timer <= 0)
      counterEnd()
      instance.stop()
    else
      updateStatus()
      timer--
    return
    
  return instance
    
    
myCounter = new Countdown({  
    endTime: "Wed Oct 31 2012 15:00:00"
})

myCounter.start()
