#> sgp.majeurs:pco/clone_cage
$execute if entity @s[nbt={data:{cage:$(cage)}}] at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] run clone $(x) $(y) $(z) $(x2) $(y2) $(z2) ~ ~ ~