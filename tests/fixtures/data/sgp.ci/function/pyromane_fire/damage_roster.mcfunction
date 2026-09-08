#> sgp.ci:pyromane_fire/damage_roster

function sgp.ci:pyromane_fire/fixture
dummy FireOwner spawn
dummy FireNear spawn
dummy FireEdge spawn
dummy FirePeace spawn
dummy FireOutside spawn
tag FireOwner add sgp.ci.fire_actor
tag FireNear add sgp.ci.fire_actor
tag FireEdge add sgp.ci.fire_actor
tag FirePeace add sgp.ci.fire_actor
tag FireOutside add sgp.ci.fire_actor
gamemode survival @a[tag=sgp.ci.fire_actor,name=!FireOwner]
gamemode survival FireOwner
gamemode creative @s
scoreboard players set FireOwner sgp.id 91001
tp FireOwner ~0.5 ~1 ~0.5
tp FireNear ~2.5 ~1 ~0.5
tp FireEdge ~4 ~1 ~0.5
tp FirePeace ~0.5 ~1 ~2.5
tp FireOutside ~0.5 ~1 ~3.5
