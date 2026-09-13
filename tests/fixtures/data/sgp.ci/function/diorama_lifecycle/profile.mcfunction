#> sgp.ci:diorama_lifecycle/profile
# Executed as an existing representation, with the expected owner's UUID saved by the scenario.
assert data entity @s profile.id
data modify storage sgp.ci:diorama_lifecycle actual_profile set from entity @s profile.id
execute store success score #ci.lifecycle.profile sgp.dummy run data modify storage sgp.ci:diorama_lifecycle actual_profile set from storage sgp.ci:diorama_lifecycle owner
assert score #ci.lifecycle.profile sgp.dummy matches 0
execute store result score #ci.lifecycle.labels sgp.dummy on passengers if entity @s[tag=sgp.fake_nametag,type=text_display]
assert score #ci.lifecycle.labels sgp.dummy matches 1
