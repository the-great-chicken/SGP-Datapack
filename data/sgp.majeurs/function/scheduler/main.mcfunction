function #bs.time:get
execute if score $time.hours bs.out matches 21 if score $time.minutes bs.out matches 58 run function sgp.majeurs:scheduler/protect
execute if score $time.hours bs.out matches 22 if score $time.minutes bs.out matches 43 run function sgp.majeurs:scheduler/hide_and_seek
execute if score $time.hours bs.out matches 23 if score $time.minutes bs.out matches 28 run function sgp.majeurs:scheduler/pco
schedule function sgp.majeurs:scheduler/main 60s