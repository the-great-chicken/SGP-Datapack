#> sgp.majeurs:protect/_stop
#
# Stop the Protéger le Roi major event

tag @a remove sgp.roi_rouge
tag @a remove sgp.roi_bleu

function sgp.majeurs:common/stop

execute as @a \
    run trigger sgp.devenir_roi_bleu set 0

execute as @a \
    run trigger sgp.devenir_roi_rouge set 0


function sgp.majeurs:common/rounds with storage sgp:data majeurs.protect