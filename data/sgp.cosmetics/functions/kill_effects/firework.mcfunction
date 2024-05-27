#> sgp.cosmetics:kill_effects/firework
# 
# Firework kill effect

execute at @e[tag=sgp.marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[tag=sgp.marker,name="death_reaper"] run summon firework_rocket ~0.3 ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[tag=sgp.marker,name="death_reaper"] run summon firework_rocket ~-0.3 ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[tag=sgp.marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~0.3 {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[tag=sgp.marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~-0.3 {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}