#> sgp.kits:abilities/fangs/summon_owned
# Executed as the Vindicateur at the final fang position.

summon evoker_fangs ~ ~ ~ {Tags:["sgp.new"]}
data modify entity @n[tag=sgp.new,distance=..0.1,limit=1,type=evoker_fangs] Owner set from entity @s UUID
tag @e[tag=sgp.new,distance=..0.1,type=evoker_fangs] remove sgp.new
