# Diorama module

This module populates one or multiple dioramas with mannequins replicating the players inside and outside, and with interaction entities and text display to allow teleporting inside the dioramas with an animation.

# Dependencies

This modules requires the Position, Health, and Link modules of [**Bookshelf**](https://docs.mcbookshelf.dev/en/latest/).

# Installation

Create your diorama in your resource pack with the following process :
- To Be Described

## Markers to create

- At least 1 `playable_map_model` in the corner of the smaller model of the map: `{id: int}`. The id should correspond to the one of the `playable_map` it should be linked to. No duplicates.

## Storages

- `sgp:data spawns[{id:int, list:[]}]` The `list` is containing all the spawns. Data of an item: `{x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>, article:<"à la"|"au"|...>, title:<text_component>, icon:"<char>"}`. Due to how we setup the macro, if you want to use a text component instead of a char for the icon, you need to do it like this (example): `icon:'",{text:"hamster",color:blue},"'` with the commas and the quotation marks.

## Other stuff

- If you want the diorama mannequins to replicate players' swings, and don't use `/give` in general (else you'll have stacking issues), you can enable it with `/scoreboard players set #mannequins_swing_enabled sgp.dummy 1`