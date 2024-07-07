$tag @r[scores={sgp.kit_prefix_set=0},tag=sgp.$(kit)] add sgp.adding_prefix
scoreboard players set @p[tag=sgp.adding_prefix] sgp.kit_prefix_set 1
$luckperms user @p[tag=sgp.adding_prefix] parent settrack kit $(kit)