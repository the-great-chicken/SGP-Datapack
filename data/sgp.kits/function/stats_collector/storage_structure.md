# `sgp.kits:stats`

```snbt
{
  schema_version: 6,
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

`death_positions` aggregates genuine in-game deaths by dimension and feet
position. Each coordinate is stored as `floor(Pos * 10)`, and the three scaled
integers form the fixed `"x,y,z"` compound key. For example,
`"-124,645,987": 3` means three deaths in the bucket beginning at
`(-12.4, 64.5, 98.7)` blocks. Synthetic cleanup, out-of-game deaths, and deaths
during a statistics pause are not collected.

`schema_version` is a strict format identifier. Collectors and the extractor
stop on any other version; no in-pack migration or compatibility path exists.

Elo starts at 1000 and uses the logistic expectation with a 1050-point rating
divisor. The winner gains `K * (1 - expected_score)` and the loser gives up the
same amount. One shared K is selected from the floor of the two participants'
average pre-fight encounter count: 80 below 25, 50 from 25 through 74, 30 from
75 through 149, and 18 from 150 onward. Runtime ratings are stored in
centi-Elo. `k_factor` records the initial/maximum value for tabular report
compatibility; `k_factor_schedule` is the authoritative schedule.

`sgp.elo_display` is deliberately absent for a player until their 30th rated
encounter. It is rounded down to a whole-Elo sidebar value whenever that
player's rating is next applied after an encounter.

All accumulated statistics pause while
`sgp.majeurs:event_in_progress` is true. Online kit-pick intervals close at the
start boundary. Offline intervals retain their start and paused-tick snapshot,
so event and synthetic-cleanup ticks are subtracted when they are later closed.
