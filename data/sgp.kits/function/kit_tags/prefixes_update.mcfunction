$tag @r[scores={sgp.kit_prefix_set=0},tag=$(kit)] add addingPrefix
scoreboard players set @a[tag=addingPrefix,limit=1] sgp.kit_prefix_set 1
$luckperms user @a[tag=addingPrefix,limit=1] parent settrack kit $(kit)