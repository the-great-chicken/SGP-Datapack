execute in minisjeux_crea at @e[type=marker,name="kits",limit=1] as @a[distance=..3,team=Poule] run function sgp.majeurs:pco/poule/kit
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Poule] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Poule] 2498.5 239 2185.5
targetglow @a[team=Poule] @a[gamemode=survival,team=Poule] RED
targetglow @a[team=Poule] @a[gamemode=survival,team=Canard] GREEN