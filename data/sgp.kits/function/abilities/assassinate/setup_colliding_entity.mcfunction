#> sgp.kits:abilities/assassinate/setup_colliding_entity
#
# The hitbox entity should only live for a few ticks, and shouldn't be seen

function #bs.health:time_to_live {with:{time:2,unit:"t"}}
data merge entity @s {NoGravity:true,Silent:true,active_effects:[{id:"minecraft:invisibility",amplifier:0b,duration:-1,show_particles:false}]}