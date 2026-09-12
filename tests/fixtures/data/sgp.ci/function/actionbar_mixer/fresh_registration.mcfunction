#> sgp.ci:actionbar_mixer/fresh_registration
# PackTest can reuse a dummy name with a new UUID, while Mixer's UID scoreboard score survives by name.
# Remove only the row referenced by any inherited score, then force this UUID through new_player again.

execute if score @s dah.actbar.UID matches 1.. store result storage sgp.ci:actionbar_mixer stale_uid int 1 run scoreboard players get @s dah.actbar.UID
execute if score @s dah.actbar.UID matches 1.. run function sgp.ci:actionbar_mixer/remove_uid with storage sgp.ci:actionbar_mixer
scoreboard players reset @s dah.actbar.UID
advancement revoke @s only dah.actbar_mixer:new_player
data remove storage sgp.ci:actionbar_mixer stale_uid
