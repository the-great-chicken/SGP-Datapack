#> sgp.majeurs:hide_and_seek/running
#
# Resolve Cache-cache team win conditions while a round is active.

execute unless entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] run return 0
execute if entity @a[team=sgp.seeker] unless entity @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/hiders_eliminated
execute unless entity @a[team=sgp.seeker] if entity @a[team=sgp.hider] run function sgp.majeurs:hide_and_seek/_stop
