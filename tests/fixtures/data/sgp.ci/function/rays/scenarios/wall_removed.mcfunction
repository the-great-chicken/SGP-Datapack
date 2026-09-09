#> sgp.ci:rays/scenarios/wall_removed

function sgp.ci:rays/fixture
setblock 8 88 12 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
setblock 8 88 12 air
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"31990..32010",center:"7995..8005"}
