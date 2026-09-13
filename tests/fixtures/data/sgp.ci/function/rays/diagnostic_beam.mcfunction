#> sgp.ci:rays/diagnostic_beam
# Append the executing beam's transform/link metadata to the current damage diagnostic snapshot.

data modify storage sgp.ci:rays beam set value {}
data modify storage sgp.ci:rays beam.tags set from entity @s Tags
data modify storage sgp.ci:rays beam.pos set from entity @s Pos
data modify storage sgp.ci:rays beam.rotation set from entity @s Rotation
execute store result storage sgp.ci:rays beam.parent int 1 run scoreboard players get @s bs.link.to
data modify storage sgp.ci:rays diagnostic.beams append from storage sgp.ci:rays beam
