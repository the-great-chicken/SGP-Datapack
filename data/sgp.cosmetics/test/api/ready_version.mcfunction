#> sgp.cosmetics:api/ready_version
# @dummy
# @environment sgp.ci:cosmetics
#
# The plugin-facing readiness endpoint reports API version 1 exactly.

data modify storage sgp.ci:cosmetics_api ready set value {}
execute store result storage sgp.ci:cosmetics_api ready.value int 1 run function sgp.cosmetics:api/ready
assert data storage sgp.ci:cosmetics_api ready{value:1}
data remove storage sgp.ci:cosmetics_api ready
