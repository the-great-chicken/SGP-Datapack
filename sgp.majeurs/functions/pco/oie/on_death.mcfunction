execute in minisjeux_crea at @e[type=marker,name="kits",limit=1] as @a[distance=..3,team=sgp.Oie] run function sgp.majeurs:pco/oie/kit
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Oie] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=sgp.Oie] 2529.5 248 2142.5
targetglow @a[team=sgp.Oie] @a[gamemode=survival,team=sgp.Oie] YELLOW
targetglow @a[team=sgp.Oie] @a[gamemode=survival,team=sgp.Poule] RED