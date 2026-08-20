# `sgp.kits:stats`

```snbt
{
  damage_cause_names: {
    "<cause_id:int>": string
  },
  kit_settings: {
    "<kit_id:int>": {
      ability_cooldown: int
    }
  },
  kits_dict: {
    "<player_id:int>": {
      "<kit_id:int>": {
        ability_use: int,
        kills: {
          "<victim_kit_id:int>": {
            "<cause_id:int>": int
          }
        },
        damage_received: {
          "<source_player_id:int>": {
            "<source_kit_id:int>": {
              "<cause_id:int>": int
            }
          }
        },
        pick: {
          total_time: int,
          nbr_picks: int
        }
      }
    }
  }
}
```

-1 for a player or kit id is no player/no kit.

`damage_received` values use Minecraft's `damage_taken` unit: tenths of a health
point after mitigation and absorption (`10` is one health point, or half a heart).
Only positive health damage received by players tagged `sgp.in_game` is recorded.
