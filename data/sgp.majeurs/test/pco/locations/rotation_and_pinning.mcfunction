#> sgp.majeurs:pco/locations/rotation_and_pinning
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Automatic selection rotates and wraps; pinning freezes the queue, and configuration changes leave the current arena active until the next selection.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_alpha"}
function sgp.ci:pco/expect_order {first:"ci_beta",second:"ci_alpha"}
assert entity @e[tag=sgp.ci.pco,tag=sgp.pco.active,nbt={data:{pco_location:"ci_alpha"}},distance=..24,type=marker]
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.active,nbt={data:{pco_location:"ci_beta"}},distance=..24,type=marker]

tag @e[tag=sgp.ci.pco,tag=sgp.pco.active,name=pco_oie_cage_arena,distance=..24,type=marker] add sgp.pco.cage_open
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_beta"}
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.active,nbt={data:{pco_location:"ci_alpha"}},distance=..24,type=marker]
assert not entity @e[tag=sgp.ci.pco,tag=sgp.pco.cage_open,distance=..24,type=marker]
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_alpha"}

function sgp.majeurs:pco/locations/pin {id:"ci_beta"}
assert data storage sgp:data majeurs.pco.active_location{id:"ci_alpha"}
function sgp.majeurs:pco/locations/select
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_beta"}
function sgp.ci:pco/expect_order {first:"ci_beta",second:"ci_alpha"}
function sgp.majeurs:pco/locations/first {id:"ci_alpha"}
assert data storage sgp:data majeurs.pco.active_location{id:"ci_beta"}
function sgp.majeurs:pco/locations/unpin
function sgp.majeurs:pco/locations/select
assert data storage sgp:data majeurs.pco.active_location{id:"ci_alpha"}
function sgp.ci:pco/expect_order {first:"ci_beta",second:"ci_alpha"}
