#> sgp.majeurs:pco/locations/registration_and_order
# @dummy
# @environment sgp.ci:pco/synchronous
#
# Registration preserves order without duplicates; unknown IDs cannot change the configured rotation or pin.

function sgp.ci:pco/fixture
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.majeurs:pco/locations/add {id:"ci_beta"}
function sgp.ci:pco/expect_order {first:"ci_alpha",second:"ci_beta"}
function sgp.majeurs:pco/locations/add {id:"ci_alpha"}
function sgp.ci:pco/expect_order {first:"ci_beta",second:"ci_alpha"}
function sgp.majeurs:pco/locations/first {id:"ci_alpha"}
function sgp.ci:pco/expect_order {first:"ci_alpha",second:"ci_beta"}

function sgp.majeurs:pco/locations/pin {id:"ci_beta"}
function sgp.majeurs:pco/locations/add {id:"ci_missing"}
function sgp.majeurs:pco/locations/first {id:"ci_missing"}
function sgp.majeurs:pco/locations/pin {id:"ci_missing"}
function sgp.ci:pco/expect_order {first:"ci_alpha",second:"ci_beta"}
assert data storage sgp:data majeurs.pco.pinned_location{id:"ci_beta"}
assert not data storage sgp:data majeurs.pco.active_location
assert chat ".*Aucun lieu PCO configuré.*ci_missing.*" @s
assert chat ".*Lieu PCO inconnu.*ci_missing.*" @s
