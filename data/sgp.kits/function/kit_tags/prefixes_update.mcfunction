$tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.$(kit)] add sgp.adding_prefix
scoreboard players set @a[tag=sgp.adding_prefix,limit=1] sgp.kit_prefix_set 1
$luckperms user @a[tag=sgp.adding_prefix,limit=1] parent settrack kit $(kit)