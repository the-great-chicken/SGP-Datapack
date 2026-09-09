#> sgp.ci:diorama_transition/cleanup
function sgp.ci:players/cleanup
kill @e[tag=sgp.anim_target,scores={sgp.id=92001..92002},type=marker]
kill @e[tag=sgp.cam,scores={sgp.id=92001..92002},type=block_display]
kill @e[tag=sgp.ci.transition_destination,type=marker]
