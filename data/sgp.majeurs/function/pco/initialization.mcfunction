#> sgp.majeurs:pco/initialization
# Create PCO-owned objectives, teams, and actionbar state.

execute unless data storage sgp:data majeurs.pco.locations run data modify storage sgp:data majeurs.pco.locations set value []
scoreboard objectives add sgp.liberer_oies trigger
scoreboard objectives add sgp.liberer_poules trigger
scoreboard objectives add sgp.liberer_canards trigger
scoreboard objectives add sgp.temps_cabane_pco dummy
scoreboard objectives add sgp.temps_cabane_pco_secondes dummy
scoreboard objectives add sgp.en_cage dummy
scoreboard objectives add sgp.ab.pco_cabane dummy
scoreboard players set #sgp.ab.width.pco_cabane sgp.dummy 410

team add sgp.Oie
team modify sgp.Oie collisionRule never
team modify sgp.Oie color yellow
team modify sgp.Oie friendlyFire false

team add sgp.Poule
team modify sgp.Poule collisionRule never
team modify sgp.Poule color red
team modify sgp.Poule friendlyFire false

team add sgp.Canard
team modify sgp.Canard collisionRule never
team modify sgp.Canard color green
team modify sgp.Canard friendlyFire false
