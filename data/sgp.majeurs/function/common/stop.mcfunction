#> sgp.majeurs:common/stop
#
# Things that get executed at the end of every major event

gamemode survival @a[tag=sgp.major_participant]
gamemode survival @a[tag=sgp.major_spectator]
scoreboard players set @a[tag=sgp.major_participant] sgp.synthetic_death 1
scoreboard players set @a[tag=sgp.major_participant] sgp.just_died 1
scoreboard players set @a[tag=sgp.major_participant] sgp.streak_en_cours 0
glow remove @a[tag=sgp.major_participant]
glow remove @a[tag=sgp.major_spectator]
team leave @a[tag=sgp.major_participant]
team leave @a[tag=sgp.major_spectator]

# Unlike a selector, `team empty` also removes offline scoreboard members.
# Clear every team that can keep an event_in_progress predicate true.
team empty sgp.rouge
team empty sgp.bleue
team empty sgp.Oie
team empty sgp.Poule
team empty sgp.Canard
team empty sgp.hider
team empty sgp.seeker

function sgp.lore:npcs/enable
experience set @a[tag=sgp.major_participant] 0 levels
experience set @a[tag=sgp.major_spectator] 0 levels
useglow toggle
tag @a remove sgp.major_participant
tag @a remove sgp.major_spectator
