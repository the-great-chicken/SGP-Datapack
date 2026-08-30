#> sgp.majeurs:scheduler/stop
#
# Stop future scheduled events and rounds. This does not stop an active event.

schedule clear sgp.majeurs:scheduler/main
schedule clear sgp.majeurs:pco/_start
schedule clear sgp.majeurs:hide_and_seek/_start
schedule clear sgp.majeurs:protect/_start
