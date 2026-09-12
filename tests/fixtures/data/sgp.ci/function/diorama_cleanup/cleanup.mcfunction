#> sgp.ci:diorama_cleanup/cleanup
# Disconnect the owner and remove every mannequin/label created by the removal fixture.
# Successful tests retire and await mannequins before teardown; this remains a failure-path fallback.

function sgp.ci:diorama_cleanup/retire
function sgp.ci:players/cleanup
