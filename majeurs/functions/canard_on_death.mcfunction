execute in minisjeux_crea as @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Canard] run function majeurs:pco_canard
execute in minisjeux_crea run effect give @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Canard] resistance infinite 5 true
execute in minisjeux_crea run tp @a[x=2423,y=251.5,z=2145.5,distance=..3,team=Canard] 2479.5 244 2139.0
execute in minisjeux_crea run setblock 2416 251 2167 redstone_block
schedule clear majeurs:canard_on_death