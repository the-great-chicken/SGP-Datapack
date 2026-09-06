#> sgp.majeurs:pco/teams/balanced_participants
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Seven participants are assigned once with team sizes differing by at most one; spectators and other online players are excluded.

function sgp.ci:pco/fixture
tag @s add sgp.major_participant
dummy PcoBalanceA spawn
tag PcoBalanceA add sgp.ci.pco_actor
tag PcoBalanceA add sgp.major_participant
dummy PcoBalanceB spawn
tag PcoBalanceB add sgp.ci.pco_actor
tag PcoBalanceB add sgp.major_participant
dummy PcoBalanceC spawn
tag PcoBalanceC add sgp.ci.pco_actor
tag PcoBalanceC add sgp.major_participant
dummy PcoBalanceD spawn
tag PcoBalanceD add sgp.ci.pco_actor
tag PcoBalanceD add sgp.major_participant
dummy PcoBalanceE spawn
tag PcoBalanceE add sgp.ci.pco_actor
tag PcoBalanceE add sgp.major_participant
dummy PcoBalanceF spawn
tag PcoBalanceF add sgp.ci.pco_actor
tag PcoBalanceF add sgp.major_participant
dummy PcoSpectator spawn
tag PcoSpectator add sgp.ci.pco_actor
tag PcoSpectator add sgp.major_spectator
tag PcoSpectator add sgp.in_game
gamemode spectator PcoSpectator
dummy PcoOutside spawn
tag PcoOutside add sgp.ci.pco_actor

function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:7,min:2,max:3}
assert not entity @a[tag=sgp.major_participant,team=!sgp.Poule,team=!sgp.Canard,team=!sgp.Oie]
assert not entity @a[team=sgp.Poule,tag=!sgp.major_participant]
assert not entity @a[team=sgp.Canard,tag=!sgp.major_participant]
assert not entity @a[team=sgp.Oie,tag=!sgp.major_participant]
assert entity @a[name=PcoSpectator,gamemode=spectator,tag=sgp.major_spectator]

function sgp.majeurs:pco/dispatch
function sgp.ci:pco/expect_teams {total:7,min:2,max:3}
assert not entity @a[tag=sgp.major_participant,team=!sgp.Poule,team=!sgp.Canard,team=!sgp.Oie]
