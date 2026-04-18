# Kits module

This module allows you to unlock cosmetics and select them.

## List of cosmetics

### Kill Effects

- Anvil
- Explosion
- Portal
- Witch
- Hurt
- Cloud
- Splash
- Firework

### Particle Cloaks

- Cloud
- Marine
- Smoke
- Ench
- Flame Crown

### Particle Cloaks intensity

- Light
- Medium
- Heavy
- Super_Heavy

## Installation

### Interaction Entities

You will need to create interaction entities to allow players to select cosmetics. All of these are optionals, you can just choose not to allow your players to select some of the effects for example.
The template to summon one is `/summon interaction ~ ~ ~ {CustomName:"<name>",Tags:["sgp.interaction"], data:{args:{<args>}, function: "<func>"}, width: 1f, height: 0.7f, response:true}`.

- 1 `choose_particle` per particle cloak, with the function `sgp.cosmetics:particles/reset_and_replace` and args: `particle:<lowercase_string>, particle_name:<text_to_display>, color:<color>`
- 1 `choose_intensity` per particle cloak intensity, with the function `sgp.cosmetics:particles/reset_and_replace_intensity` and args: `intensity:<lowercase_string>, intensity_name:<text_to_display>, color:<color>`
- 1 `choose_kill_effect` per kill effect, with the function `sgp.cosmetics:kill_effects/reset_and_replace` and args: `kill:<lowercase_string>, kill_name:<text_to_display>, color:<color>`
- 1 `disable_cloak`, with the function `sgp.cosmetics:particles/manually_disable` and no args
- 1 `disable_kill_effect`, with the function `sgp.cosmetics:kill_effects/manually_disable` and no args