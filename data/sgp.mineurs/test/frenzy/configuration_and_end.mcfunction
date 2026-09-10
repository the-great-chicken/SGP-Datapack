#> sgp.mineurs:frenzy/configuration_and_end
#
# Halve every configured cooldown, preserve other ability settings, and restore the exact configuration on expiry.

data modify storage sgp.ci:frenzy configuration_and_end set value {}
data modify storage sgp.ci:frenzy configuration_and_end.original set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set value {cleave:{cooldown:300s},bats:{cooldown:301,duration:101s},"custom:ability":{cooldown:7s,duration:19s},ready:{cooldown:0s},last_tick:{cooldown:1s}}
function sgp.mineurs:frenzy/start
data modify storage sgp.ci:frenzy configuration_and_end.during set from storage sgp:data kits.ability_cooldowns
function sgp.mineurs:frenzy/end
data modify storage sgp.ci:frenzy configuration_and_end.after set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data kits.ability_cooldowns set from storage sgp.ci:frenzy configuration_and_end.original
schedule clear sgp.misc:second

assert data storage sgp.ci:frenzy configuration_and_end.during{cleave:{cooldown:150s},bats:{cooldown:150s,duration:101s},"custom:ability":{cooldown:3s,duration:19s},ready:{cooldown:0s},last_tick:{cooldown:0s}}
assert data storage sgp.ci:frenzy configuration_and_end.after{cleave:{cooldown:300s},bats:{cooldown:301,duration:101s},"custom:ability":{cooldown:7s,duration:19s},ready:{cooldown:0s},last_tick:{cooldown:1s}}
data remove storage sgp.ci:frenzy configuration_and_end
