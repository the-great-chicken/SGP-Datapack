#> sgp.kits:kills_give/check
# 
# Checks if a player made a kill, and if so, which kit they have.
#
# Runs the appropriate function to reward them for their kill.

execute as @a[tag=sgp.alchimiste] run function sgp.kits:collection/alchimiste/on_kill
execute as @a[tag=sgp.archer] run function sgp.kits:collection/archer/on_kill
execute as @a[tag=sgp.cancer] run function sgp.kits:collection/cancer/on_kill
execute as @a[tag=sgp.combattant] run function sgp.kits:collection/combattant/on_kill
execute as @a[tag=sgp.eclaireur] run function sgp.kits:collection/eclaireur/on_kill
execute as @a[tag=sgp.enderman] run function sgp.kits:collection/enderman/on_kill
execute as @a[tag=sgp.pigeon] run function sgp.kits:collection/pigeon/on_kill
execute as @a[tag=sgp.poseidon] run function sgp.kits:collection/poseidon/on_kill
execute as @a[tag=sgp.pyromane] run function sgp.kits:collection/pyromane/on_kill
execute as @a[tag=sgp.roi] run function sgp.kits:collection/roi/on_kill
execute as @a[tag=sgp.tank] run function sgp.kits:collection/tank/on_kill
execute as @a[tag=sgp.vindicateur] run function sgp.kits:collection/vindicateur/on_kill