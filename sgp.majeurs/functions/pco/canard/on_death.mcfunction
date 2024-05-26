execute in minisjeux_crea at @e[tag=sgp.marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Canard] run function sgp.majeurs:pco/canard/kit
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Canard] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Canard] 2479.5 244 2139.0
targetglow @a[team=sgp.Canard] @a[gamemode=survival,team=sgp.Canard] GREEN
targetglow @a[team=sgp.Canard] @a[gamemode=survival,team=sgp.Oie] YELLOW