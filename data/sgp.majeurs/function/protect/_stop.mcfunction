#> sgp.majeurs:protect/_stop
#
# Stop the Protéger le Roi major event

tag @a remove sgp.roi_rouge
tag @a remove sgp.roi_bleu


execute as @a \
    run trigger sgp.devenir_roi_bleu set 0

execute as @a \
    run trigger sgp.devenir_roi_rouge set 0


useglow toggle

function sgp.majeurs:common/rounds with storage sgp:data majeurs.pco

function sgp.majeurs:common/stop