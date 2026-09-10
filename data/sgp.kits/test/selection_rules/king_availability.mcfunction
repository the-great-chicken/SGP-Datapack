#> sgp.kits:selection_rules/king_availability
# @dummy
# @environment sgp.ci:kit_selection
#
# Either team's active king blocks manual King selection, while an out-of-game king does not.

execute store result storage sgp.ci:selection_rules king_availability.idle int 1 run function sgp.kits:can_give {kit:"roi"}
dummy KitKingActor spawn
tag KitKingActor add sgp.roi_bleu
execute store result storage sgp.ci:selection_rules king_availability.inactive_blue int 1 run function sgp.kits:can_give {kit:"roi"}
tag KitKingActor add sgp.in_game
execute store result storage sgp.ci:selection_rules king_availability.active_blue int 1 run function sgp.kits:can_give {kit:"roi"}
tag KitKingActor remove sgp.roi_bleu
tag KitKingActor add sgp.roi_rouge
execute store result storage sgp.ci:selection_rules king_availability.active_red int 1 run function sgp.kits:can_give {kit:"roi"}
tag KitKingActor remove sgp.in_game
execute store result storage sgp.ci:selection_rules king_availability.inactive_red int 1 run function sgp.kits:can_give {kit:"roi"}
tag KitKingActor remove sgp.roi_rouge
tag KitKingActor add sgp.in_game
execute store result storage sgp.ci:selection_rules king_availability.ordinary_player int 1 run function sgp.kits:can_give {kit:"roi"}
dummy KitKingActor leave

assert data storage sgp.ci:selection_rules king_availability{idle:1,inactive_blue:1,active_blue:0,active_red:0,inactive_red:1,ordinary_player:1}
data remove storage sgp.ci:selection_rules king_availability
