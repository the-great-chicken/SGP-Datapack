#> sgp.majeurs:pco/targeting/wrong_team
# @dummy
# @environment sgp.ci:pco_targeting/wrong_team
#
# Looking at a teammate, a predator, or an unassigned player does not grant the hunting bonus.

function sgp.ci:pco_targeting/fixture
function sgp.ci:pco_targeting/check_pair {hunter:Poule,prey:Poule,damage:1000}
function sgp.ci:pco_targeting/check_pair {hunter:Poule,prey:Oie,damage:1000}
team leave PcoPrey
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
team leave @s
team join sgp.Canard PcoPrey
function sgp.majeurs:pco/empower
function sgp.ci:pco_targeting/expect_damage {damage:1000}
