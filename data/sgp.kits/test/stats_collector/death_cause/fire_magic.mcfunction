#> sgp.kits:stats_collector/death_cause/fire_magic
# @dummy
#
# Fire, explosions, magic and reflected damage keep distinct analytics ids.

function sgp.ci:death_cause/expect {cause:"fire_tick",id:11}
function sgp.ci:death_cause/expect {cause:"fire_contact",id:12}
function sgp.ci:death_cause/expect {cause:"lava",id:13}
function sgp.ci:death_cause/expect {cause:"explosion",id:14}
function sgp.ci:death_cause/expect {cause:"indirect_magic",id:15}
function sgp.ci:death_cause/expect {cause:"magic_effect",id:16}
function sgp.ci:death_cause/expect {cause:"thorns",id:17}
