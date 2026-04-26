# SGP-Datapack

The Datapack for the Soirée du Grand Poulet

# About

The Soirée du Grand Poulet is a Minecraft event mostly centered around PvP. This is the datapack that contains the kits, events, etc.

You can join the discord of the original SGP at https://www.discord.gg/FqGKSqPBbk

# Dependencies

## Required

The [**Actionbar**](https://wiki.smithed.dev/libraries/actionbar/) datapack from Smithed is required.
[**Bookshelf**](https://docs.mcbookshelf.dev/en/latest/) is also required.

## Optional

You need [**CommandAPI**](https://commandapi.jorel.dev/) to use plugin commands in datapacks, as well as [**Luckperms**](https://luckperms.net/), the [**TGCPlugin**](https://github.com/the-great-chicken/TGC-Plugin-v2/tree/main) and [**DiscordSRV**](https://www.spigotmc.org/resources/discordsrv.18494/) + **_an add-on for the /move command_**.
You can bypass these dependencies by removing every non-vanilla command from the datapack. The actions performed by these custom commands are independent from the rest of the datapack (making players glow, moving them from a voice channel to another...) so removing them shouldn't break anything.
We strongly recommend the Worldguard plugin, as some things in the datapack might have not been tested without it.
For example tnt-based abilities will destroy your world, or poseidon's trident ability will place water that might flow under certain circumstances.

## Compatibility issues

We do replace the #bypasses_shield damage type tag with all its vanilla damage type, to allow us to have a damage type that bypasses armor but not shield.
We also replace the vanilla magenta_shulker_box death loot table.

# Installation

Add the datapack to your world, and add the necessary markers in your world, that specify the location of objects. These markers **must** all have the tag `sgp.marker`.

## Markers to create

### Base

- 1 `respawn`: spawnpoint of the players when they die, should be also the place where they choose their kit
- any number of `lieu` with data corresponding to the POI. Example : `data:{dx:16, dy:3, dz:6, lieu:observatoire, lieu_propre:"Observatoire", couleur:"#DDDDDD"}`. Need 8 `\` to escape a `'`.
- any number of `teleporter` with data corresponding to the teleporter destination : `data:{x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>}`
- at least 1 `Confinement`: spawnpoints when the Confinement event is active
- at least 1 `Lootdrop`: locations of lootdrop chests, with the visual direction of the chest: `data:{facing:<direction>}`
- optionally 1 `jump_diff_2`, 1 `jump_hardest`, 1 `laby_fin`: specific locations for parkour rewards. Not really flexible though.
- 1 `abilities_shulker`: somewhere hidden, in an empty (air) block, to allow abilities to work
- 1 `playable_map` in the corner of the playable map: `{dx, dy, dz}`
- Optionally 1 `playable_map_model` in the corner of the smaller model of the map.

### Major Events

- at least 1 `Attaquant_Invasion`: spawnpoints when the Invasion event is active
- 1 `devenir_roi_rouge` and 1 `devenir_roi_bleu`: These are rooms where a player can become the Roi when "Protéger le Roi" is active. Note that Devenir Roi Rouge and Devenir Roi Bleu cannot be in the same location.
- 1 `devenir_chasseur` and 1 `devenir_pigeon`: These are rooms where players can become Chasseurs or Pigeons. Note that Devenir Chasseur and Devenir Pigeons cannot be in the same location.
- 3 `pco_cage_storage`: one for each team. They should not be placed somewhere visible, and are used to clone the cages from there to the arena at the start of the event. They should have the following data: `{cage:"<team>", dx, dy, dz}` The 3 first `dx dy dz` are the size of the cages.
- 3 `pco_uncage_storage`: one for each team. They should be near the `pco_cage_storage`s, and should have the following data: `{cage:"<team>", dx, dy, dz}`
- 3 `pco_<team>_cage_arena` that should be placed in the corner of the cage of the team, in the arena.
- 3 `pco_<team>_spawn` that are the place at which the players from the specified team spawn
- 3 `pco_spawn_cage_<team>` that are the place at which the players from the specified team respawn when he is capture
- 1 `spawn_seeker` spawn of the seeker team
- 1 `spawn_hider` spawn of the hider team

Additional Note: The markers for Devenir Roi Rouge and Devenir Chasseur can share the same location. Similarly, the markers for Devenir Roi Bleu and Devenir Pigeons can share the same location.

## Interaction Entities

The template to summon one is `/summon interaction ~ ~ ~ {CustomName:"<name>",Tags:["sgp.interaction"], data:{args:{<args>}, function: "<func>"}, width: 1f, height: 0.7f, response:true}`.
Each of these is optional (or can be present multiple times), depending on how you want to make your players' UX.

- `spawn_tper` for each spawnpoint the players can choose, with the function `sgp.misc:interactions/tp_to_spawn` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>, text:"<escaped_text_component>` <a href="#note1">*</a>
- `spawn_randomizer`, with the function `sgp.misc:interactions/random_spawn` and no args
- `to_spawns`, with the function `sgp.misc:interactions/go_to_choose_spawn` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_cosm`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_reception`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`
- `to_kits`, with the function `sgp.misc:interactions/simple_tp` and args: `x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>`

<a id="note1">*</a> There needs to be the same number of `spawn_tper` for each spawn type, or else the random will be skewed.

## Other stuff
- `gamerule advance_time` must be set to `false` for some effects to work properly, and the time to be set at 10000. This limitation should be removed when the pack will be upgraded to Minecraft 26.1.
- Whatever is described in the [Kits module Readme](data/sgp.kits/README.md)
- Whatever is described in the [Cosmetics module Readme](data/sgp.cosmetics/README.md)

# Uninstallation

Run the `sgp.misc:uninstall` function, it will remove all the sgp objectives and non-usermade data
