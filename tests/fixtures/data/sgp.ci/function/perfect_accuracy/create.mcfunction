#> sgp.ci:perfect_accuracy/create
# {type, motion}
# Create a projectile owned by the executing shooter, before its first physics tick.

$summon $(type) ~ ~2 ~ {Tags:["sgp.ci.accuracy","sgp.ci.accuracy_new"],Motion:$(motion)}
$data modify entity @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)] Owner set from entity @s UUID
