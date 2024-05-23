$execute as @a[scores={sgp.$(kit)_found=0},distance=..5] run scoreboard players enable @s sgp.$(kit)_found
$execute as @a[scores={sgp.$(kit)_found=0},distance=..5] run scoreboard players set @s sgp.$(kit)_found 1
$execute as @a[scores={sgp.$(kit)_found=1},distance=5..] run trigger sgp.$(kit)_found set 0