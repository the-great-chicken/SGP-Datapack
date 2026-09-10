#> sgp.mineurs:frenzy/missing_configuration
# @dummy
#
# Without cooldown settings, Frenzy refuses to start and leaves players unchanged; a later valid start still works.

data modify storage sgp.ci:frenzy missing_configuration set value {}
data modify storage sgp.ci:frenzy missing_configuration.original set from storage sgp:data kits.ability_cooldowns
tag @s add sgp.in_game
scoreboard players set @s sgp.cooldown_ability 100
data remove storage sgp:data kits.ability_cooldowns
execute store success storage sgp.ci:frenzy missing_configuration.started byte 1 run function sgp.mineurs:frenzy/start
execute store result storage sgp.ci:frenzy missing_configuration.before_valid_start int 1 run scoreboard players get @s sgp.cooldown_ability

data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:300s}}
function sgp.mineurs:frenzy/start
data modify storage sgp.ci:frenzy missing_configuration.during set from storage sgp:data kits.ability_cooldowns
execute store result storage sgp.ci:frenzy missing_configuration.after_valid_start int 1 run scoreboard players get @s sgp.cooldown_ability
function sgp.mineurs:frenzy/stop
data modify storage sgp:data kits.ability_cooldowns set from storage sgp.ci:frenzy missing_configuration.original
schedule clear sgp.misc:second

assert data storage sgp.ci:frenzy missing_configuration{started:0b,before_valid_start:100,during:{cleave:{cooldown:150s}},after_valid_start:50}
data remove storage sgp.ci:frenzy missing_configuration
