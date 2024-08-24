# SGP-Datapack

The Datapack for the Soirée du Grand Poulet

# About

The Soirée du Grand Poulet is a Minecraft event mostly centered around PvP. This is the datapack that contains the kits, events, etc.

You can join the discord of the original SGP at https://www.discord.gg/FqGKSqPBbk

# Dependencies

## Required

The [**Actionbar**](https://wiki.smithed.dev/libraries/actionbar/) datapack from Smithed is required

## Optional

You need [**CommandAPI**](https://commandapi.jorel.dev/) to use plugin commands in datapacks, as well as [**Luckperms**](https://luckperms.net/), the [**TGCPlugin**](https://github.com/the-great-chicken/TGC-Plugin-v2/tree/main) and [**DiscordSRV**](https://www.spigotmc.org/resources/discordsrv.18494/) + **_an add-on for the /move command_**.
You can bypass these dependencies by removing every non-vanilla command from the datapack. The actions performed by these custom commands are independent from the rest of the datapack (making players glow, moving them from a voice channel to another...) so removing them shouldn't break anything.

# Installation

Add the datapack to your world, and add the necessary markers in your world, that specify the location of objects. These markers **must** all have the tags `sgp.marker` and `global.ignore`

## Markers to create

### Base

- 1 `accueil`: room where the players spawn
- 1 `salle_cosm`: room where the players can change cosmetics
- 1 `kits`: room where the players can choose their kit
- 1 `spawns`: room where the players choose their spawnpoint
- any number of `lieu` with data corresponding to the POI. Example : `data:{dx:16, dy:3, dz:6, lieu:observatoire, lieu_propre:"Observatoire", couleur:"#DDDDDD"}`. Need 8 `\` to escape a `'`.
- any number of `teleporter` with data corresponding to the teleporter destination : `data:{x:<x>, y:<y>, z:<z>, yaw:<yaw>, pitch:<pitch>}`
- at least 1 `spawn` : one of the spawnpoints players can choose. `data:{number:<int>, text:"<escaped_json_text_component>"}`. `number` should be serial (unique and incremented), starting from one. Example of `text` : `"[\"Tu as spawn au \",{\"text\":\"Labyrinthe\", \"color\":\"light_purple\", \"bold\":true}]"`
- at least 1 `Confinement`: spawnpoints when the Confinement event is active
- at least 1 `Lootdrop`: location of lootdrop chests
- optionally 1 `jump_diff_2`, 1 `jump_hardest`, 1 `laby_fin`: specific locations for parkour rewards. Not really flexible though.

### Major Events

- at least 1 `Attaquant_Invasion`: spawnpoints when the Invasion event is active
- 1 `devenir_roi_rouge` and 1 `devenir_roi_bleu`: These are rooms where a player can become the Roi when "Protéger le Roi" is active. Note that Devenir Roi Rouge and Devenir Roi Bleu cannot be in the same location.
- 1 `devenir_chasseur` and 1 `devenir_pigeon`: These are rooms where players can become Chasseurs or Pigeons. Note that Devenir Chasseur and Devenir Pigeons cannot be in the same location.
- 3 `pco_cage_storage`: one for each team. They should not be placed somewhere visible, and are used to clone the cages from there to the arena at the start of the event. They should have the following data: `{cage:"<team>", dx, dy, dz, fill:{x, y, z, dx, dz}}` The 3 first `dx dy dz` are the size of the cages. The `x y z` in `fill{}` are the differences between the position of the linked `pco_<team>_cage_arena` and the corner of the cabane. `dx and dz` in the `fill{}` are the size of the cabane.
- 3 `pco_uncage_storage`: one for each team. They should be near the `pco_cage_storage`s, and should have the following data: `{cage:"<team>", dx, dy, dz}`
- 3 `pco_<team>_cage_arena` that should be placed in the corner of the cage of the team, in the arena.
- 1 `spawn_seeker` spawn of the seeker team
- 1 `spawn_hider` spawn of the hider team

Additional Note: The markers for Devenir Roi Rouge and Devenir Chasseur can share the same location. Similarly, the markers for Devenir Roi Bleu and Devenir Pigeons can share the same location.

# Uninstallation

Run the `sgp.misc:uninstall` function, it will remove all the sgp objectives
