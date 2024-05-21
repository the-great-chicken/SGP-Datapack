execute in minisjeux_crea at @e[type=marker,name="kits",limit=1] as @a[distance=..3,team=Oie] run function majeurs_pco:oie
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Oie] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Oie] 2529.5 248 2142.5
targetglow @a[team=Oie] @a[gamemode=survival,team=Oie] YELLOW
targetglow @a[team=Oie] @a[gamemode=survival,team=Poule] RED