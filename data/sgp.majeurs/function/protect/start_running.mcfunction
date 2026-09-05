#> sgp.majeurs:protect/start_running
#
# Equip both selected kings and release both teams into the arena.

scoreboard players set #protect_phase sgp.dummy 2

execute as @a[tag=sgp.roi_rouge,team=sgp.rouge] run function sgp.majeurs:protect/equip_king {side:rouge}
execute as @a[tag=sgp.roi_bleu,team=sgp.bleue] run function sgp.majeurs:protect/equip_king {side:bleu}
execute as @a[tag=sgp.major_participant,team=sgp.rouge,tag=!sgp.roi_rouge] run function sgp.kits:clear_and_tp_to_kits
execute as @a[tag=sgp.major_participant,team=sgp.bleue,tag=!sgp.roi_bleu] run function sgp.kits:clear_and_tp_to_kits
function sgp.majeurs:protect/update_glow
