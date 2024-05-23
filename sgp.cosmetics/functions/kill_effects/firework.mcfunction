execute at @e[type=minecraft:marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[type=minecraft:marker,name="death_reaper"] run summon firework_rocket ~0.3 ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[type=minecraft:marker,name="death_reaper"] run summon firework_rocket ~-0.3 ~1 ~ {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[type=minecraft:marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~0.3 {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
execute at @e[type=minecraft:marker,name="death_reaper"] run summon firework_rocket ~ ~1 ~-0.3 {LifeTime:20, FireworksItem:{id:"firework_rocket", Count:1, tag:{Fireworks:{Flight:1}}}}
scoreboard players set @a death_effect 0