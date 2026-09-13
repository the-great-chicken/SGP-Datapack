#> sgp.majeurs:pco/cages/clone_isolation
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Restore copies the complete structure and container contents into only the active arena's requested cage, including negative source extents.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}
assert block ~6 ~1 ~ red_concrete
assert block ~7 ~1 ~1 red_concrete
assert block ~6 ~2 ~ glass
assert block ~7 ~2 ~1 barrel
assert data block ~7 ~2 ~1 Items[{Slot:0b,id:"minecraft:diamond",count:7}]
assert block ~8 ~2 ~1 air
assert block ~6 ~1 ~4 blue_concrete
assert block ~10 ~1 ~ gold_block

function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/cage/restore {cage:"oie"}
assert block ~6 ~1 ~4 emerald_block
assert block ~7 ~2 ~5 emerald_block
assert block ~8 ~2 ~5 air
assert block ~6 ~1 ~ red_concrete
assert data block ~7 ~2 ~1 Items[{Slot:0b,id:"minecraft:diamond",count:7}]
assert block ~10 ~1 ~ gold_block
