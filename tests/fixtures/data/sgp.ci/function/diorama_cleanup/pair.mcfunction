#> sgp.ci:diorama_cleanup/pair
# {group, type, map, owner, x}
$summon mannequin $(x) ~1 ~3.5 {Tags:["sgp.ci.removal","sgp.ci.removal_$(group)","sgp.$(type)_mannequin_$(map)"],NoGravity:true,Invulnerable:true,immovable:true}
$scoreboard players set @n[tag=sgp.ci.removal_$(group),distance=..16,type=mannequin] bs.link.to $(owner)
$summon text_display $(x) ~3 ~3.5 {Tags:["sgp.ci.removal","sgp.ci.removal_$(group)"],text:"Name"}
$ride @n[tag=sgp.ci.removal_$(group),distance=..16,type=text_display] mount @n[tag=sgp.ci.removal_$(group),distance=..16,type=mannequin]
