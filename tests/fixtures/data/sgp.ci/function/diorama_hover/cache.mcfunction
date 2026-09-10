#> sgp.ci:diorama_hover/cache
# Record the executing interaction UUID in the same production hover cache used by spawned buttons.

function gu:generate
data modify storage sgp.ci:diorama_hover entry set value {}
data modify storage sgp.ci:diorama_hover entry.uuid set from storage gu:main out
data modify storage sgp:data misc.diorama.spawn_interactions.id_93001 append from storage sgp.ci:diorama_hover entry
