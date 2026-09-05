#> sgp.majeurs:scheduler/main
#
# Poll the BookShelf clock once per minute.

function #bs.time:get

# Announce each event two minutes before its configured start time.
execute if score $time.hours bs.out = #pco_announcement_hour sgp.dummy if score $time.minutes bs.out = #pco_announcement_minute sgp.dummy run function sgp.majeurs:scheduler/message with storage sgp:data majeurs.pco
execute if score $time.hours bs.out = #hide_and_seek_announcement_hour sgp.dummy if score $time.minutes bs.out = #hide_and_seek_announcement_minute sgp.dummy run function sgp.majeurs:scheduler/message with storage sgp:data majeurs.hide_and_seek
execute if score $time.hours bs.out = #protect_announcement_hour sgp.dummy if score $time.minutes bs.out = #protect_announcement_minute sgp.dummy run function sgp.majeurs:scheduler/message with storage sgp:data majeurs.protect

# Start at the configured time. scheduler/run resets the shared round counter.
execute if score $time.hours bs.out = #pco_hour sgp.dummy if score $time.minutes bs.out = #pco_minute sgp.dummy run function sgp.majeurs:scheduler/run with storage sgp:data majeurs.pco
execute if score $time.hours bs.out = #hide_and_seek_hour sgp.dummy if score $time.minutes bs.out = #hide_and_seek_minute sgp.dummy run function sgp.majeurs:scheduler/run with storage sgp:data majeurs.hide_and_seek
execute if score $time.hours bs.out = #protect_hour sgp.dummy if score $time.minutes bs.out = #protect_minute sgp.dummy run function sgp.majeurs:scheduler/run with storage sgp:data majeurs.protect

schedule function sgp.majeurs:scheduler/main 60s replace
