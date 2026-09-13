#> sgp.majeurs:pco/cages/capture_routing
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Deferred captures reject stale rounds/roles and send a valid participant to the active arena's cage without moving a teammate.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.majeurs:pco/locations/select
team join sgp.Oie @s
tag @s add sgp.major_participant
tag @s add sgp.pco.awaiting_cage
function sgp.majeurs:pco/cage/capture {team:"Oie"}
execute positioned ~12.5 ~1 ~3.5 run assert entity @s[distance=..0.01]
scoreboard players set #pco_phase sgp.dummy 2
team join sgp.Poule @s
function sgp.majeurs:pco/cage/capture {team:"Oie"}
execute positioned ~12.5 ~1 ~3.5 run assert entity @s[distance=..0.01]
team join sgp.Oie @s
tag @s remove sgp.major_participant
function sgp.majeurs:pco/cage/capture {team:"Oie"}
execute positioned ~12.5 ~1 ~3.5 run assert entity @s[distance=..0.01]

dummy PcoCaptureOther spawn
tag PcoCaptureOther add sgp.ci.pco_actor
team join sgp.Oie PcoCaptureOther
tp PcoCaptureOther ~13.5 ~1 ~3.5
tag @s add sgp.major_participant
function sgp.majeurs:pco/cage/capture {team:"Oie"}
execute positioned ~6.5 ~2 ~0.5 run assert entity @s[distance=..0.01]
assert not entity @s[tag=sgp.pco.awaiting_cage]
execute positioned ~13.5 ~1 ~3.5 run assert entity @a[name=PcoCaptureOther,distance=..0.01]

function sgp.majeurs:pco/locations/select
tag @s add sgp.pco.awaiting_cage
function sgp.majeurs:pco/cage/capture {team:"Oie"}
execute positioned ~6.5 ~2 ~4.5 run assert entity @s[distance=..0.01]
assert not entity @s[tag=sgp.pco.awaiting_cage]
