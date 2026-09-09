#> sgp.ci:hider_reveal/scenarios/expect_stopped

assert not entity @s[nbt={active_effects:[{id:"minecraft:glowing"}]}]
execute store result score #ci.reveal.pending sgp.dummy run schedule clear sgp.majeurs:hide_and_seek/timer/glow
assert score #ci.reveal.pending sgp.dummy matches 0
execute store result score #ci.reveal.pending sgp.dummy run schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce
assert score #ci.reveal.pending sgp.dummy matches 0
