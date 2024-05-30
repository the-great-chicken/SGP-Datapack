# SGP-Datapack
The Datapack for the Soirée du Grand Poulet


# About
The Soirée du Grand Poulet is a Minecraft event mostly centered around PvP. This is the datapack that contains the kits, events, etc.

You can join the discord of the original SGP at https://www.discord.gg/FqGKSqPBbk


# Dependencies
## Required
The [**Actionbar**](https://wiki.smithed.dev/libraries/actionbar/) datapack from Smithed is required 
## Optional
You need [**CommandAPI**](https://commandapi.jorel.dev/) to use plugin commands in datapacks, as well as [**Luckperms**](https://luckperms.net/), the [**TGCPlugin**](https://github.com/the-great-chicken/TGC-Plugin-v2/tree/main) and [**DiscordSRV**](https://www.spigotmc.org/resources/discordsrv.18494/) + ***an add-on for the /move command***.
You can bypass these dependencies by removing every non-vanilla command from the datapack. The actions performed by these custom commands are independent from the rest of the datapack (making players glow, moving them from a voice channel to another...) so removing them shouldn't break anything.


# Installation
Add the datapack to your world, and add the necessary markers in your world, that specify the location of objects. These markers **must** all have the tags `sgp.marker` and `global.ignore`
## Markers to create
- 1 `accueil`: room where the players spawn
- 1 `salle_cosm`: room where the players can change cosmetics
- 1 `kits`: room where the players can choose their kit
- 1 `spawns`: room where the players choose their spawnpoint
- at least 1 `lieu` with data corresponding to the place. Example : `data:{x:2524, y:248, z:2141, dx:16, dy:3, dz:6, lieu:observatoire, lieu_propre:"Observatoire", couleur:"#DDDDDD"}`
- at least 1 `Confinement`: spawnpoints when the Confinement event is active
- at least 1 `Lootdrop`: location of lootdrop chests
- at least 1 `Attaquant_Invasion`: spawnpoints when the Invasion event is active
- 1 `devenir_roi_rouge` and 1 `devenir_roi_bleu`: These are rooms where a player can become the Roi when "Protéger le Roi" is active. Note that Devenir Roi Rouge and Devenir Roi Bleu cannot be in the same location.
- 1 `devenir_chasseur` and 1 `devenir_pigeon`: These are rooms where players can become Chasseurs or Pigeons. Note that Devenir Chasseur and Devenir Pigeons cannot be in the same location.

Additional Note: The markers for Devenir Roi Rouge and Devenir Chasseur can share the same location. Similarly, the markers for Devenir Roi Bleu and Devenir Pigeons can share the same location.


# Uninstallation
Run the `sgp.misc:uninstall` function, it will remove all the sgp objectives
