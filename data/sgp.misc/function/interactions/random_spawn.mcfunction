#> sgp.misc:interactions/random_spawn
# `{id: int}`

$tag @e[tag=sgp.spawn_tper,limit=1,sort=random,type=interaction,nbt={data:{args:{id:$(id)}}}] add sgp.selected

execute at @e[limit=1,tag=sgp.selected,type=interaction] \
    run function sgp.misc:interactions/tp_to_spawn with entity @e[limit=1,tag=sgp.selected,type=interaction] data.args

tag @e[limit=1,tag=sgp.selected,type=interaction] remove sgp.selected