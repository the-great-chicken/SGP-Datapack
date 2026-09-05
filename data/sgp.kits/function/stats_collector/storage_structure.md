# `sgp.kits:stats`

```snbt
{
  schema_version: 7,
  players: {
    "<player_id:int>": {
      uuid: int_array,
      nickname: string
    }
  },
  damage_cause_names: {
    "<cause_id:int>": string
  },
  death_position_metadata: {
    stored_unit: "block_tenths",
    display_unit: "blocks",
    display_scale: double,
    quantization: "floor",
    position_reference: "feet"
  },
  death_positions: {
    "<dimension:string>": {
      "<x_tenths:int>,<y_tenths:int>,<z_tenths:int>": int
    }
  },
  elo_metadata: {
    initial_rating: double,
    k_factor: double,
    k_factor_schedule: [{
      minimum_average_encounters: int,
      k_factor: double
    }],
    rating_divisor: double,
    metrics: {
      rating: {
        name: string,
        description: string,
        stored_unit: "centi_elo",
        display_unit: "elo",
        display_scale: double
      },
      rated_encounters: {
        name: string,
        description: string,
        stored_unit: "count",
        display_unit: "encounters",
        display_scale: double
      }
    }
  },
  elo_ratings: {
    "<player_id:int>": {
      rating: int,
      rated_encounters: int
    }
  },
  ability_metadata: {
    "<kit_id:int>": {
      "<ability_path:string>": {
        cooldown: int,
        duration?: int,
        settings?: compound,
        metrics: {
          "<metric_id:string>": {
            name: string,
            description: string,
            stored_unit: string,
            display_unit: string,
            display_scale: double,
            source: {
              type: "ability_field",
              field: string
            } | {
              type: "damage_received",
              source_kit_id: int,
              cause_ids: [int],
              exclude_self: boolean
            }
          }
        }
      }
    }
  },
  kits_dict: {
    "<player_id:int>": {
      "<kit_id:int>": {
        abilities: {
          "<ability_path:string>": {
            "<stored_metric_id:string>": int
          }
        },
        kills: {
          "<victim_player_id:int>": {
            "<victim_kit_id:int>": {
              "<cause_id:int>": int
            }
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
          nbr_picks: int,
          last_pick?: int,
          paused_ticks?: int
        }
      }
    }
  }
}
```

`-1` for a player or kit id means no player/no kit.

`players` maps each persistent `sgp.id` to the player's Minecraft UUID and the
nickname observed during their latest connection in this edition. The UUID is
stored in Minecraft's native four-integer array representation.


All accumulated statistics pause while
`sgp.majeurs:event_in_progress` is true. Online kit-pick intervals close at the
start boundary. Offline intervals retain their start and paused-tick snapshot,
so event and synthetic-cleanup ticks are subtracted when they are later closed.
