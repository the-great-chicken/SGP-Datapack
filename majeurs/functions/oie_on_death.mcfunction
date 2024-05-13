execute in minisjeux_crea as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Oie] run function majeurs:pco_oie
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Oie] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Oie] 2529.5 248 2142.5
execute in minisjeux_crea run setblock 2416 251 2167 redstone_block
schedule clear majeurs:oie_on_death