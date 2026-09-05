#> sgp.majeurs:pco/cabane/actionbar_tick
# Expire PCO refuge actionbar segments.

scoreboard players remove @a[scores={sgp.ab.pco_cabane=1..}] sgp.ab.pco_cabane 1
execute as @a[scores={sgp.ab.pco_cabane=0}] run function dah.actbar_mixer:remove/this {id:"sgp:pco_cabane"}
execute as @a[scores={sgp.ab.pco_cabane=0}] run scoreboard players reset @s sgp.ab.pco_cabane
