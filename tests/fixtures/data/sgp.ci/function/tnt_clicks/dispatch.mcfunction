#> sgp.ci:tnt_clicks/dispatch
# The same Bookshelf advancement handler used by the registered left-click listener.
execute at @s run function bs.interaction:on_event/left_click/left_click
assert not entity @s[tag=bs.interaction.source]
assert not entity @e[tag=bs.interaction.target,type=interaction]
