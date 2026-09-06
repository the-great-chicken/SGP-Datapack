#> sgp.ci:pco/round_fixture
# An active round with four participants, all three cage floors, and one arena selected.

function sgp.ci:pco/fixture
fill ~10 ~1 ~ ~11 ~1 ~1 red_concrete
fill ~18 ~1 ~ ~19 ~1 ~1 red_concrete
summon marker ~18 ~1 ~ {CustomName:"pco_canard_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.ci.pco"],data:{pco_location:"ci_alpha"}}
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}

team join sgp.Oie @s
dummy PcoRoundOie spawn
tag PcoRoundOie add sgp.ci.pco_actor
team join sgp.Oie PcoRoundOie
tp PcoRoundOie ~16.5 ~1 ~3.5
dummy PcoRoundPoule spawn
tag PcoRoundPoule add sgp.ci.pco_actor
team join sgp.Poule PcoRoundPoule
tp PcoRoundPoule ~14.5 ~1 ~3.5
dummy PcoRoundCanard spawn
tag PcoRoundCanard add sgp.ci.pco_actor
team join sgp.Canard PcoRoundCanard
tp PcoRoundCanard ~15.5 ~1 ~3.5

tag @a[tag=sgp.ci.pco_actor] add sgp.major_participant
tag @a[tag=sgp.ci.pco_actor] add sgp.in_game
gamemode creative @a[tag=sgp.ci.pco_actor]
scoreboard players set @a[tag=sgp.ci.pco_actor] sgp.en_cage 0
scoreboard players set @a[tag=sgp.ci.pco_actor] sgp.temps_cabane_pco 100
scoreboard players set #pco_phase sgp.dummy 2
