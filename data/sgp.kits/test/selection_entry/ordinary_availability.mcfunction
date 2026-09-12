#> sgp.kits:selection_entry/ordinary_availability
# @dummy
# @environment sgp.ci:kit_selection
#
# Every ordinary kit exposes a working can_give handler and is selectable in an idle context.

execute store result storage sgp.ci:selection_entry availability.alchimiste int 1 run function sgp.kits:can_give {kit:"alchimiste"}
execute store result storage sgp.ci:selection_entry availability.archer int 1 run function sgp.kits:can_give {kit:"archer"}
execute store result storage sgp.ci:selection_entry availability.cancer int 1 run function sgp.kits:can_give {kit:"cancer"}
execute store result storage sgp.ci:selection_entry availability.combattant int 1 run function sgp.kits:can_give {kit:"combattant"}
execute store result storage sgp.ci:selection_entry availability.eclaireur int 1 run function sgp.kits:can_give {kit:"eclaireur"}
execute store result storage sgp.ci:selection_entry availability.enderman int 1 run function sgp.kits:can_give {kit:"enderman"}
execute store result storage sgp.ci:selection_entry availability.pigeon int 1 run function sgp.kits:can_give {kit:"pigeon"}
execute store result storage sgp.ci:selection_entry availability.poseidon int 1 run function sgp.kits:can_give {kit:"poseidon"}
execute store result storage sgp.ci:selection_entry availability.pyromane int 1 run function sgp.kits:can_give {kit:"pyromane"}
execute store result storage sgp.ci:selection_entry availability.tank int 1 run function sgp.kits:can_give {kit:"tank"}
execute store result storage sgp.ci:selection_entry availability.vindicateur int 1 run function sgp.kits:can_give {kit:"vindicateur"}

assert data storage sgp.ci:selection_entry availability{alchimiste:1,archer:1,cancer:1,combattant:1,eclaireur:1,enderman:1,pigeon:1,poseidon:1,pyromane:1,tank:1,vindicateur:1}
data remove storage sgp.ci:selection_entry availability
