#> sgp.majeurs:scheduler/abort
#
# Stop the scheduler and the active major event without starting another round.

function sgp.majeurs:scheduler/stop
# common/rounds increments before comparing; leave one point of headroom.
scoreboard players set #rounds sgp.dummy 2147483646

function #sgp.majeurs:events/abort
