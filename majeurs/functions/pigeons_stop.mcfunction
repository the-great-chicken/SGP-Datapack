tag @a remove tag1
setblock 2480 230 2166 air
execute as @a run trigger devenir_chasseur set 0
execute as @a run trigger devenir_pigeon set 0
function majeurs:stop
