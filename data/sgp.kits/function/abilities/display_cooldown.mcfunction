#> sgp.kits:abilities/display_cooldown
#
# `{type: name of the scoreboard containing the cooldown, every: int}`

# Stop execution unless ticks are a multiple of $every ticks
$scoreboard players operation #tick_conversion_remainder sgp.dummy = @s sgp.$(type)
$scoreboard players operation #tick_conversion_remainder sgp.dummy %= $(every) sgp.dummy
execute unless score #tick_conversion_remainder sgp.dummy matches 0 run return 1

# Calculate the whole seconds
$scoreboard players operation #seconds sgp.dummy = @s sgp.$(type)
scoreboard players operation #seconds sgp.dummy /= 20 sgp.dummy

# Calculate the decimals (tenths of a second)
$scoreboard players operation #tenths sgp.dummy = @s sgp.$(type)
scoreboard players operation #tenths sgp.dummy %= 20 sgp.dummy
scoreboard players operation #tenths sgp.dummy /= 2 sgp.dummy

tellraw @s [ \
  {"text": "Vous êtes encore en cooldown pendant ", "color": "red"}, \
  {"score": {"name": "#seconds", "objective": "sgp.dummy"}, "color": "gold", "bold": true}, \
  {"text": ".", "color": "gold", "bold": true}, \
  {"score": {"name": "#tenths", "objective": "sgp.dummy"}, "color": "gold", "bold": true}, \
  {"text": " secondes", "color": "red"} \
]
playsound minecraft:entity.villager.no player @s ~ ~ ~