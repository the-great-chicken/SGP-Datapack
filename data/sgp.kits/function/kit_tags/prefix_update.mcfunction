#> sgp.kits:kit_tags/prefixes_update
#
# Update the kit prefix, without sending the update message to the player
# That's why we're not using @s

scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
$luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit $(kit_name)
tag @a[tag=sgp.adding_prefix,limit=1] remove sgp.adding_prefix