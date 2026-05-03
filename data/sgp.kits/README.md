# Kits module

This module allows you to unlock kits, select them, and introduces special abilities for each one.

## List of kits
- Alchimiste
- Archer
- Cancer
- Combattant
- Eclaireur
- Enderman
- Peaceful *
- Pigeon
- Poseidon
- Pyromane
- Roi
- Tank
- Vindicateur

> The Peaceful kit functions exactly as any other kit, it needs to have the same types of Interaction Entities/storage.

## Installation
### Interaction Entities

You will need to create interaction entities to allow players to interact with the module (select kits, unlock them,...).
The template to summon one is `/summon interaction ~ ~ ~ {Tags:["sgp.interaction", "sgp.<name>"], data:{args:{<args>}, function: "<func>"}, response:true}`.

- 1 `choose_kit` per kit, with the function `sgp.kits:check_and_give` and args: `kit:<lowercase_string>, kit_name:<string_to_display>, kit_color:<color>, hint:<escaped_text_component>, hint_color:<color>` <a href="#note1">*</a> <a href="#note2">**</a>
- 1 `choose_kit_randomizer`, with the function `sgp.kits:random_kit` and no args
- 1 `kit_unlock`, with the function `sgp.kits:unlocking/unlocking_kit` and args: `kit:<lowercase_string>, kit_color:<color>, fw_color:<decimal_color>"`

<a id="note1">*</a> The Peaceful kit's interaction entity should have another name, like `choose_kit_peaceful` to avoid it being a random kit possibility.
<a id="note2">**</a> There needs to be the same number of `choose_kit` for each kit, or else the random will be skewed.