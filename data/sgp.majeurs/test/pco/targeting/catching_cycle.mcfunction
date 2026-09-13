#> sgp.majeurs:pco/targeting/catching_cycle
# @dummy
# @environment sgp.ci:pco_targeting/catching_cycle
#
# Each team gains the bonus against its intended prey, without also empowering that prey.

function sgp.ci:pco_targeting/fixture
function sgp.ci:pco_targeting/check_pair {hunter:Poule,prey:Canard,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
function sgp.ci:pco_targeting/check_pair {hunter:Canard,prey:Oie,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
function sgp.ci:pco_targeting/check_pair {hunter:Oie,prey:Poule,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
