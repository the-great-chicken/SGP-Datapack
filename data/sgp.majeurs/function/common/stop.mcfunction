#> sgp.majeurs:common/stop
# 
# Things that get executed at the end of every major event

gamemode survival @a[tag=sgp.in_game]
scoreboard players set @a[tag=sgp.in_game] sgp.synthetic_death 1
scoreboard players set @a[tag=sgp.in_game] sgp.just_died 1
scoreboard players set @a[tag=sgp.in_game] sgp.streak_en_cours 0
glow remove @a
team leave @a[tag=sgp.in_game]

# Unlike a selector, `team empty` also removes offline scoreboard members.
# Clear every team that can keep an event_in_progress predicate true.
team empty sgp.rouge
team empty sgp.bleue
team empty sgp.Oie
team empty sgp.Poule
team empty sgp.Canard
team empty sgp.hider
team empty sgp.seeker

statuswarp pvp enabled
function sgp.lore:npcs/enable
experience set @a[tag=sgp.in_game] 0 levels
useglow toggle
