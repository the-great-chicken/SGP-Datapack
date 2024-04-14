execute in minisjeux_crea as @a[x=2423, y=251.5, z=2145.5, distance=..3, team=Poule] run function majeurs:pco_poule
execute in minisjeux_crea run effect give @a[x=2423, y=251.5, z=2145.5, distance=..3, team=Poule] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423, y=251.5, z=2145.5, distance=..3, team=Poule] 2498.5 239 2185.5
execute in minisjeux_crea run setblock 2416 251 2167 redstone_block
schedule clear majeurs:poule_on_death