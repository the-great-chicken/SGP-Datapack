#> sgp.kits:abilities/rays/cleanup
# Every 10 ticks, expire beams that missed a full refresh interval. Unloaded beams expire after loading.

# No spatial arguments: this selector covers loaded beams in every dimension.
kill @e[tag=sgp.ray,tag=!sgp.ray_refreshed,type=item_display]
tag @e[tag=sgp.ray,type=item_display] remove sgp.ray_refreshed
