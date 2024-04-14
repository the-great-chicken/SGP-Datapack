$execute as @a[scores={$(kit)_found=0},distance=..5] run scoreboard players enable @s $(kit)_found
$execute as @a[scores={$(kit)_found=0},distance=..5] run scoreboard players set @s $(kit)_found 1
$execute as @a[scores={$(kit)_found=1},distance=5..] run trigger $(kit)_found set 0