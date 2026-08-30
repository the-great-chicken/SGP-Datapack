# Major Events Module

Available major events:

- `pco`: Poule Canard Oie
- `hide_and_seek`: Cache-cache
- `protect`: Protéger le Roi

## Operator quick start

The scheduler is deliberately not started by the datapack load function. Configure it, and then start it manually for each SGP edition.

```mcfunction
/function sgp.majeurs:config/show
/function sgp.majeurs:config/pco {hour:22,minute:0,rounds:3}
/function sgp.majeurs:config/hide_and_seek {hour:22,minute:45,rounds:3}
/function sgp.majeurs:config/protect {hour:23,minute:30,rounds:3}
/function sgp.majeurs:scheduler/start
```

`hour` must be in `0..23`, `minute` in `0..59`, and `rounds` must be at least `1`. A round count includes the first round: `rounds:3` runs exactly three rounds. There are 30 seconds between rounds.

The configured time is the actual event start time. The scheduler announces the event two minutes earlier. `config/show` displays that clock alongside the current settings.

Defaults for a new installation are:

| Event            | Start | Rounds |
|------------------|------:|-------:|
| Poule Canard Oie | 22:00 | 3      |
| Cache-cache      | 22:45 | 3      |
| Protéger le Roi  | 23:30 | 3      |

### Manual controls

Start the scheduler loop, or cleanly restart it during maintenance:
```mcfunction
/function sgp.majeurs:scheduler/start
```

Stop future daily starts and any waiting next round without interrupting an event that is already active:
```mcfunction
/function sgp.majeurs:scheduler/stop
```

Stop both the scheduler and the currently active major event, without launching a new round:
```mcfunction
/function sgp.majeurs:scheduler/abort
```

For testing, start an event immediately while still honoring its configured number of rounds:
```mcfunction
/function sgp.majeurs:scheduler/run {event:"pco"}
/function sgp.majeurs:scheduler/run {event:"hide_and_seek"}
/function sgp.majeurs:scheduler/run {event:"protect"}
```

## Installation

The template to summon a marker is `/summon marker ~ ~ ~ {CustomName:"<name>", Tags:["sgp.marker"], data:{<data>}}`.
All markers with a bounding box (`dx, dy, dz`) must be positioned in the corner with coordinates `- - -` of the bounding box, at `<x>.0 <y>.0 <z>.0`.
Keep every marker and its associated structures in forceloaded chunks.

### Protéger le Roi setup

| Marker                 | Count    | Purpose                  |
|------------------------|---------:|--------------------------|
| `devenir_roi_rouge`    | 1        | Red role-selection room  |
| `devenir_roi_bleu`     | 1        | Blue role-selection room |
| `protect_spawn_rouges` | 1        | Red team arena spawn     |
| `protect_spawn_bleus`  | 1        | Blue team arena spawn    |
| `pvp_arena`            | 1        | Final-death destination and arena sound origin |
| `respawn`              | 1 shared | Detects player deaths (shared with normal respawns, don't duplicate it!) |

The two role-selection markers must be in distinct locations. At event start, the datapack rewrites the block at local position `^ ^1 ^1` from each marker as the clickable "Devenir le Roi" sign. Position and rotate each marker so that this block is the intended sign.

### Poule Canard Oie setup

PCO supports multiple arena/location sets. Every marker belonging to the selected set must also have the `sgp.enabled` tag, and inactive sets must not have that tag. Enable exactly one complete set before starting PCO.

In the table below, `<team>` is lowercase `poule`, `canard`, or `oie`, while `<Team>` is title-case `Poule`, `Canard`, or `Oie`.

| Marker                  | Count per enabled set | Required data / purpose                                                     |
|-------------------------|----------------------:|-----------------------------------------------------------------------------|
| `pco_cage_storage`      | 3                     | One source cage per team with `{cage:"<team>",dx:<int>,dy:<int>,dz:<int>}`  |
| `pco_uncage_storage`    | 3                     | One uncaged source per team with the same `cage`, `dx`, `dy`, and `dz` data |
| `pco_<team>_cage_arena` | 3                     | Destination corner for the arena cage                                       |
| `pco_<team>_spawn`      | 3                     | Initial team spawns                                                         |
| `pco_spawn_cage_<Team>` | 3                     | Respawn points for captured players; capitalization is significant          |
| `respawn`               | 1 shared              | Detects player deaths                                                       |

The cloned cages must contain the clickable signs that run the corresponding trigger:

- `sgp.liberer_poules`
- `sgp.liberer_canards`
- `sgp.liberer_oies`

### Cache-cache setup

| Marker         | Count | Purpose      |
|----------------|------:|--------------|
| `spawn_seeker` | 1     | Seeker spawn |
| `spawn_hider`  | 1     | Hider spawn  |
