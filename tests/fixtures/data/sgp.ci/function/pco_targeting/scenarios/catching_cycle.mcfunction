#> sgp.ci:pco_targeting/scenarios/catching_cycle

function sgp.ci:pco_targeting/fixture
function sgp.ci:pco_targeting/check_pair {hunter:Poule,prey:Canard,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
function sgp.ci:pco_targeting/check_pair {hunter:Canard,prey:Oie,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
function sgp.ci:pco_targeting/check_pair {hunter:Oie,prey:Poule,damage:7000}
execute as PcoPrey run function sgp.ci:pco_targeting/expect_damage {damage:1000}
