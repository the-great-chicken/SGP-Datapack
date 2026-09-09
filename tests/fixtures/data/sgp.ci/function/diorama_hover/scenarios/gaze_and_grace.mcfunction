#> sgp.ci:diorama_hover/scenarios/gaze_and_grace

function sgp.ci:diorama_hover/fixture
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
function sgp.ci:diorama_hover/expect {target:second,active:0,scale:0.55}
# Brief loss of gaze keeps the selection; sustained loss releases it.
tp @s ~3.5 ~1 ~1.5 180 0
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:1,scale:0.7}
function sgp.ci:diorama_hover/update
function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
