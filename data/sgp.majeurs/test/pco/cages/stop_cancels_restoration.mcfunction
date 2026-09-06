#> sgp.majeurs:pco/cages/stop_cancels_restoration
# @dummy
# @environment sgp.ci:pco/stop
#
# Stopping opens the cage and releases round state; a pending restoration must not later overwrite the next arena.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}
team join sgp.Oie @s
tag @s add sgp.major_participant
tag @s add sgp.pco.awaiting_cage
scoreboard players set @s sgp.en_cage 0
scoreboard players set #pco_phase sgp.dummy 2
function sgp.majeurs:pco/cage/uncage {cage:"oie",team:"Oie",catchers:"Canard",team_color:"yellow"}
function sgp.majeurs:pco/_stop
assert block ~6 ~2 ~ air
assert score #pco_phase sgp.dummy matches 0
assert score #rounds sgp.dummy matches 1
assert entity @s[gamemode=survival]
assert not entity @s[team=sgp.Oie]
assert not entity @s[tag=sgp.major_participant]
assert not entity @s[tag=sgp.pco.awaiting_cage]
assert not score @s sgp.en_cage matches 0..
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.active,distance=..24,type=marker]
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.cage_open,distance=..24,type=marker]
assert not data storage sgp:data majeurs.pco.active_location
function sgp.ci:pco/expect_order {first:"ci_beta",second:"ci_alpha"}

function sgp.majeurs:pco/_stop
assert score #rounds sgp.dummy matches 1
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_beta"}
await delay 61t
assert block ~6 ~2 ~ air
assert block ~6 ~1 ~4 blue_concrete
assert block ~7 ~2 ~5 blue_concrete
assert score #rounds sgp.dummy matches 1
