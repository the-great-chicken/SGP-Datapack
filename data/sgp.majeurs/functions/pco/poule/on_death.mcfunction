execute in minisjeux_crea at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Poule] run function sgp.majeurs:pco/poule/kit
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Poule] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Poule] 2498.5 239 2185.5
targetglow @a[team=sgp.Poule] @a[gamemode=survival,team=sgp.Poule] RED
targetglow @a[team=sgp.Poule] @a[gamemode=survival,team=sgp.Canard] GREEN