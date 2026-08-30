# SGP-Datapack

The Datapack for the Soirée du Grand Poulet

# About

The Soirée du Grand Poulet is a Minecraft event mostly centered around PvP. This is the datapack that contains the kits, events, etc.

You can join the discord of the original SGP at https://www.discord.gg/FqGKSqPBbk

# Dependencies

## Required

The [**Actionbar Mixer**](https://github.com/Dahesor/Actionbar-Mixer-for-Minecraft) datapack is required.
[**Bookshelf**](https://docs.mcbookshelf.dev/en/latest/) is also required.

## Optional

You need [**CommandAPI**](https://commandapi.jorel.dev/) to use plugin commands in datapacks, as well as [**Luckperms**](https://luckperms.net/), the [**TGCPlugin**](https://github.com/the-great-chicken/TGC-Plugin-v2/tree/main) and [**DiscordSRV**](https://www.spigotmc.org/resources/discordsrv.18494/) + **_an add-on for the /move command_**.
You can bypass these dependencies by removing every non-vanilla command from the datapack. The actions performed by these custom commands are independent from the rest of the datapack (making players glow, moving them from a voice channel to another...) so removing them shouldn't break anything.
We strongly recommend the Worldguard plugin, as some things in the datapack might have not been tested without it.
For example tnt-based abilities will destroy your world, or poseidon's trident ability will place water that might flow under certain circumstances.

## Compatibility issues

We do replace the #bypasses_shield damage type tag with all its vanilla damage type, to allow us to have a damage type that bypasses armor but not shield.
We also replace the vanilla magenta_shulker_box death loot table.
We completely OWN the actionbar UwU. (Although it's possible to add things to it by calling our related functions)

# Installation

Add the datapack to your world, and add the necessary markers in your world, that specify the location of objects. These markers **must** all have the tag `sgp.marker`.

## Markers to create

The template to summon one is `/summon marker ~ ~ ~ {CustomName:"<name>", Tags:["sgp.marker"], data:{<data>}}`.
All markers with a bounding box (`dx, dy, dz`) must be positioned in the corner with coordinates `- - -` of the bounding box, at `<x>.0 <y>.0 <z>.0`. All chunks containing markers should be forceloaded.

### Base

- 1 `respawn`: spawnpoint of the players when they die, should be also the place where they choose their kit
- any number of `lieu` : They are bounding boxes corresponding to an in-game POI. The players can "collect" these by going inside, and it will show them the POI name everytime they come back in. Example : `data:{dx:16, dy:3, dz:6, lieu:observatoire, lieu_propre:"Observatoire", couleur:"#DDDDDD", width:72, exclusion_box{x:1, y:2, z:2, dx:2, dy:2, dz:2}}`. Need 8 `\` to escape a `'`. The `exclusion_box` parameter is completely optional. <a href="#note4">⚠</a>
- any number of `teleporter` with data corresponding to the teleporter destination : `data:{x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>}`. When a player is on the same block as the marker, it gets teleported after a while. The teleporter is visible through particles.
- at least 1 `Confinement`: spawnpoints when the Confinement event is active. Should better be "inside" buildings, else players will die UwU.
- at least 1 `Lootdrop`: locations of lootdrop chests, with the visual direction of the chest: `data:{facing:<direction>}`
- 1 `abilities_shulker`: somewhere hidden, in an empty (air) block, to allow abilities to work
- At least 1 `playable_map` in the corner of the playable map: `{dx, dy, dz, id: int}` (the `id` is not mandatory if you're not using dioramas)

<a id="note4">⚠</a> When testing the width, please use `/function sgp.misc:actionbar/width_test/main {text:<text component>, width:<int>}` to properly test with multiple of them (it often varies!)

## Interaction Entities

The template to summon one is `/summon interaction ~ ~ ~ {Tags:["sgp.interaction", "sgp.<name>"], data:{args:{<args>}, function: "<func>"}, response:true}`.
Each of these is optional (or can be present multiple times), depending on how you want to make your players' UX.

- `spawn_tper` for each spawnpoint the players can choose, with the function `sgp.misc:interactions/tp_to_spawn` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>, article:<"à la"|"au"|...>, title:"<escaped_text_component>", id:1` <a href="#note1">⚠</a> <a href="#note2">⚠⚠</a>
- `spawn_randomizer`, with the function `sgp.misc:interactions/random_spawn` and no arg: `id: <int>`. <a href="#note3">⚠⚠⚠</a>
- `to_spawns`, with the function `sgp.misc:interactions/go_to_choose_spawn` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_cosms`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_reception`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_kits`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`

<a id="note1">⚠</a> There needs to be the same number of `spawn_tper` for each spawn type, or else the random will be skewed.

<a id="note2">⚠⚠</a> You do not need to add any if you're using the diorama! Instead initialize the [storage](#storages).

<a id="note3">⚠⚠⚠</a> If you're not using dioramas, choose `id: 1`. Else it should be the id of the diorama it will choose the spawns from.

## Storages

- You can change the cooldowns and durations of all abilities by changing the values in `sgp:data kits.ability_cooldowns`

## Other stuff
- Whatever is described in the [Kits module Readme](data/sgp.kits/README.md)
- Whatever is described in the [Cosmetics module Readme](data/sgp.cosmetics/README.md)
- Whatever is described in the [Diorama module Readme](data/sgp.diorama/README.md)
- Whatever is described in the [Major events module Readme](data/sgp.majeurs/README.md)

## Plugin configuration

### CommandAPI

Change these settings in CommandAPI's config.yml:
```yml
skip-initial-datapack-reload: false
hook-paper-reload: true

plugins-to-convert:
- LuckPerms:
  - luckperms (user) <user>[api:players] <args>[api:greedy_string]
  - luckperms (creategroup|createtrack) <name>[brigadier:string]
  - luckperms (group) <name>[brigadier:string] (meta) (setprefix) <priority>[brigadier:integer] <prefix>[api:greedy_string]
  - luckperms (track) (kit) (append) <name>[brigadier:string]
- TGCPlugin:
  - statuswarp <name>[brigadier:string] (enabled|disabled)
- DiscordSRV-SGP-extension:
  - move <player>[api:players] <channel>[api:greedy_string]
- Citizens:
  - npc (spawn|despawn)
  - npc (select) <id>[brigadier:integer]
- Essentials:
  - playerlist

other-commands-to-convert:
  - glow add <player>[api:players] <entities>[api:entities]
  - glow add <player>[api:players] <entities>[api:entities] <color>[minecraft:color]
  - glow time <player>[api:players] <entities>[api:entities] <duration>[brigadier:integer]
  - glow time <player>[api:players] <entities>[api:entities] <duration>[brigadier:integer] <color>[minecraft:color]
  - glow remove <entities>[api:entities]
  - useglow (toggle)

skip-sender-proxy:
- LuckPerms
```

# Uninstallation

Run the `sgp.misc:uninstall` function, it will remove all the sgp objectives and non-usermade data
