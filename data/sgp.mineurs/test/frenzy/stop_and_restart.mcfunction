#> sgp.mineurs:frenzy/stop_and_restart
#
# Repeated stops must not replay a stale snapshot; a later event uses the latest configuration.

data modify storage sgp:data tests.frenzy_restart set value {}
data modify storage sgp:data tests.frenzy_restart.original set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:303s}}
function sgp.mineurs:frenzy/start
function sgp.mineurs:frenzy/stop
data modify storage sgp:data tests.frenzy_restart.first_restored set from storage sgp:data kits.ability_cooldowns

data modify storage sgp:data kits.ability_cooldowns set value {bats:{cooldown:707s,duration:13s}}
function sgp.mineurs:frenzy/stop
data modify storage sgp:data tests.frenzy_restart.after_second_stop set from storage sgp:data kits.ability_cooldowns
function sgp.mineurs:frenzy/start
data modify storage sgp:data tests.frenzy_restart.during_second_event set from storage sgp:data kits.ability_cooldowns
function sgp.mineurs:frenzy/stop
data modify storage sgp:data tests.frenzy_restart.second_restored set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set from storage sgp:data tests.frenzy_restart.original
schedule clear sgp.misc:second

assert data storage sgp:data tests.frenzy_restart.first_restored{cleave:{cooldown:303s}}
assert data storage sgp:data tests.frenzy_restart.after_second_stop{bats:{cooldown:707s,duration:13s}}
assert data storage sgp:data tests.frenzy_restart.during_second_event{bats:{cooldown:353s,duration:13s}}
assert data storage sgp:data tests.frenzy_restart.second_restored{bats:{cooldown:707s,duration:13s}}
assert not data storage sgp:data tests.frenzy_restart.second_restored.cleave
data remove storage sgp:data tests.frenzy_restart
