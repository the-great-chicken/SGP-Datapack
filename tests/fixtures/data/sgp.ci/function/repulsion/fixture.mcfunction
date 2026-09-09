#> sgp.ci:repulsion/fixture

fill ~ ~ ~ ~16 ~ ~16 stone
fill ~ ~1 ~ ~16 ~5 ~16 air
# A stationary living entity exercises Minecraft's enchantment tick without client movement or AI.
summon husk ~8.5 ~2 ~8.5 {Tags:["sgp.ci.repulsion"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b,Rotation:[0f,0f]}
item replace entity @e[tag=sgp.ci.repulsion,type=husk] armor.chest with leather_chestplate[enchantments={"sgp.kits:repulsion":1}]
scoreboard players set @e[tag=sgp.ci.repulsion,type=husk] sgp.trigger_repulsion 0
