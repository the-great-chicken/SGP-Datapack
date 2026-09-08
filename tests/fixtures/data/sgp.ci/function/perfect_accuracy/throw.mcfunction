#> sgp.ci:perfect_accuracy/throw
# {type}
# Fixed-speed throws ignore the original launch speed.

$function sgp.ci:perfect_accuracy/create {type:$(type),motion:"[0.0,0.0,0.2]"}
$assert entity @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)]
$execute as @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)] run function sgp.kits:projectile/reset_velocity
$execute as @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)] run function sgp.ci:perfect_accuracy/check {x:"-20..20",y:"-20..20",z:"14980..15020"}
$kill @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)]
