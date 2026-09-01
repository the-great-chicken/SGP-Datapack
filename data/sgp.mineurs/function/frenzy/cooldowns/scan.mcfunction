#> sgp.mineurs:frenzy/cooldowns/scan
# `{index:<inclusive index>, next:<exclusive index>}`

# A valid non-empty compound must contain a key/value colon before the end.
execute if score #haste.scan_index sgp.dummy >= #haste.snbt_length sgp.dummy run return run function sgp.mineurs:frenzy/stop

$data modify storage sgp:data mineurs.haste.walker.char set string storage sgp:data mineurs.haste.walker.snbt $(index) $(next)

# Preserve the state from before processing this character.
scoreboard players operation #haste.was_in_quote sgp.dummy = #haste.in_quote sgp.dummy
scoreboard players operation #haste.was_escaped sgp.dummy = #haste.escaped sgp.dummy

# The first colon outside quotes terminates the first compound key.
$execute if score #haste.was_in_quote sgp.dummy matches 0 if data storage sgp:data mineurs.haste.walker{char:":"} run data modify storage sgp:data mineurs.haste.walker.apply.key set string storage sgp:data mineurs.haste.walker.snbt 1 $(index)
execute if score #haste.was_in_quote sgp.dummy matches 0 \
    if data storage sgp:data mineurs.haste.walker{char:":"} \
        run return run function sgp.mineurs:frenzy/cooldowns/apply with storage sgp:data mineurs.haste.walker.apply

# Track quoted keys, including escaped characters inside them.
scoreboard players set #haste.escaped sgp.dummy 0
execute if score #haste.was_in_quote sgp.dummy matches 1 \
    if score #haste.was_escaped sgp.dummy matches 0 \
        if data storage sgp:data mineurs.haste.walker{char:"\\"} \
            run scoreboard players set #haste.escaped sgp.dummy 1

execute if score #haste.was_in_quote sgp.dummy matches 1 \
    if score #haste.was_escaped sgp.dummy matches 0 \
        if score #haste.quote_type sgp.dummy matches 1 \
            if data storage sgp:data mineurs.haste.walker{char:"\""} \
                run scoreboard players set #haste.in_quote sgp.dummy 0

execute if score #haste.was_in_quote sgp.dummy matches 1 \
    if score #haste.was_escaped sgp.dummy matches 0 \
        if score #haste.quote_type sgp.dummy matches 2 \
            if data storage sgp:data mineurs.haste.walker{char:"'"} \
                run scoreboard players set #haste.in_quote sgp.dummy 0

execute if score #haste.was_in_quote sgp.dummy matches 0 \
    if data storage sgp:data mineurs.haste.walker{char:"\""} \
        run scoreboard players set #haste.in_quote sgp.dummy 1

execute if score #haste.was_in_quote sgp.dummy matches 0 \
    if data storage sgp:data mineurs.haste.walker{char:"\""} \
        run scoreboard players set #haste.quote_type sgp.dummy 1

execute if score #haste.was_in_quote sgp.dummy matches 0 \
    if data storage sgp:data mineurs.haste.walker{char:"'"} \
        run scoreboard players set #haste.in_quote sgp.dummy 1

execute if score #haste.was_in_quote sgp.dummy matches 0 \
    if data storage sgp:data mineurs.haste.walker{char:"'"} \
        run scoreboard players set #haste.quote_type sgp.dummy 2


# Advance one character and recurse.
execute store result storage sgp:data mineurs.haste.walker.scan.index int 1 \
    run scoreboard players add #haste.scan_index sgp.dummy 1

execute store result storage sgp:data mineurs.haste.walker.scan.next int 1 \
    run scoreboard players add #haste.scan_next sgp.dummy 1
function sgp.mineurs:frenzy/cooldowns/scan with storage sgp:data mineurs.haste.walker.scan
