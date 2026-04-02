#> sgp.mineurs:confinement/stop

schedule clear sgp.mineurs:confinement/running
tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"CONFINEMENT ! ", color:gray, bold:true},{text:"L'événement est terminé ! Vous pouvez ressortir en toute securité !", color:white}]
experience set @a[tag=sgp.in_game] 0 levels
scoreboard players set #confines_secondes sgp.timer 0
time set 10000
stopsound @a[tag=sgp.in_game] master minecraft:music_disc.strad
gamerule advance_time false