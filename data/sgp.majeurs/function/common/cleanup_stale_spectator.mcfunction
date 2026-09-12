#> sgp.majeurs:common/cleanup_stale_spectator
#
# Release a spectator who was offline when the already-ended event stopped.
# Spectators keep their normal loadout, so this intentionally does not run
# synthetic-death cleanup.

function sgp.majeurs:common/reset_owned_state

gamemode survival @s
team leave @s
experience set @s 0 levels

tag @s remove sgp.major_participant
tag @s remove sgp.major_spectator

function #sgp.hooks:tgc/majeurs/common/cleanup_stale_player
function #sgp.hooks:discord/majeurs/common/cleanup_stale_player
