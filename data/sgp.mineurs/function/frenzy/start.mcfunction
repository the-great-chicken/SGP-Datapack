#> sgp.mineurs:frenzy/start

# Never overwrite the only clean backup if Haste is already running.
execute if data storage sgp:data mineurs.haste.active run return 0
execute unless data storage sgp:data kits.ability_cooldowns run return fail

# Snapshot first. stop.mcfunction restores this exact value, so odd values are safe too.
data modify storage sgp:data mineurs.haste.cd_backup set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data mineurs.haste.active set value 1b

# Work on a disposable copy of the compound to discover every ability key.
data modify storage sgp:data mineurs.haste.walker.remaining set from storage sgp:data kits.ability_cooldowns
data modify storage sgp:data mineurs.haste.walker.next.value set from storage sgp:data mineurs.haste.walker.remaining
function sgp.mineurs:frenzy/cooldowns/next with storage sgp:data mineurs.haste.walker.next
data remove storage sgp:data mineurs.haste.walker

# A malformed entry makes the walker call stop, which restores the snapshot.
execute unless data storage sgp:data mineurs.haste.active run return fail

# Halve cooldowns currently active
scoreboard players operation @a[tag=sgp.in_game] sgp.cooldown_ability /= 2 sgp.dummy

title @a[tag=sgp.in_game] title {text:"FRENZY!",color:dark_aqua,bold:true}
tellraw @a[tag=sgp.in_game] [{storage:"sgp.text",nbt:"prefix",interpret:true},{text:"FRENZY! ",color:dark_aqua,bold:true},{text:"Le Grand Poulet a divisé les temps de recharge des compétences par 2 !",color:aqua}]

function sgp.misc:timer_experience {duration:150}
schedule function sgp.mineurs:frenzy/end 150s
