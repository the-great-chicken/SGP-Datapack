#> sgp.majeurs:common/cleanup_stale_participant
#
# Finish the stop-time cleanup missed by a participant who was offline.

function sgp.majeurs:common/reset_owned_state

gamemode survival @s
team leave @s
experience set @s 0 levels
scoreboard players set @s sgp.streak_en_cours 0

tag @s remove sgp.major_participant
tag @s remove sgp.major_spectator

function #sgp.hooks:tgc/majeurs/common/cleanup_stale_player
function #sgp.hooks:discord/majeurs/common/cleanup_stale_player

# Match common/stop's synthetic-death cleanup. The main tick consumes these
# markers immediately after statistics processing and before kits/abilities.
scoreboard players set @s sgp.synthetic_death 1
scoreboard players set @s sgp.just_died 1
