#> sgp.kits:selection_rules/peaceful_during_events
# @dummy
# @environment sgp.ci:kit_selection
#
# Another player's participation in any major event blocks Peaceful mode; ordinary kits remain available and the restriction ends with the event.

execute store result storage sgp:data tests.kit_peaceful.idle int 1 run function sgp.kits:can_give {kit:"peaceful"}
dummy KitEventActor spawn
team join sgp.Oie KitEventActor
execute store result storage sgp:data tests.kit_peaceful.pco int 1 run function sgp.kits:can_give {kit:"peaceful"}
team join sgp.hider KitEventActor
execute store result storage sgp:data tests.kit_peaceful.hide_and_seek int 1 run function sgp.kits:can_give {kit:"peaceful"}
team join sgp.bleue KitEventActor
execute store result storage sgp:data tests.kit_peaceful.protect int 1 run function sgp.kits:can_give {kit:"peaceful"}
execute store result storage sgp:data tests.kit_peaceful.ordinary_kit int 1 run function sgp.kits:can_give {kit:"archer"}
team leave KitEventActor
execute store result storage sgp:data tests.kit_peaceful.after int 1 run function sgp.kits:can_give {kit:"peaceful"}
dummy KitEventActor leave

assert data storage sgp:data tests.kit_peaceful{idle:1,pco:0,hide_and_seek:0,protect:0,ordinary_kit:1,after:1}
data remove storage sgp:data tests.kit_peaceful
