#> sgp.ci:repulsion/peer

summon husk ~12.5 ~2 ~12.5 {Tags:["sgp.ci.repulsion","sgp.ci.repulsion_peer"],NoAI:1b,NoGravity:1b,Silent:1b,Invulnerable:1b}
item replace entity @e[tag=sgp.ci.repulsion_peer,type=husk] armor.chest with leather_chestplate[enchantments={"sgp.kits:repulsion":1}]
scoreboard players set @e[tag=sgp.ci.repulsion_peer,type=husk] sgp.trigger_repulsion 0
