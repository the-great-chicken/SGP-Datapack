# `sgp.kits:stats`

```snbt
{
  schema_version: 4,
  damage_cause_names: {
    "<cause_id:int>": string
  },
  elo_metadata: {
    name: string,
    description: string,
    algorithm: "elo_logistic",
    initial_rating: double,
    k_factor: double,
    rating_divisor: double,
    result_type: "credited_pvp_kill",
    major_events_rated: byte,
    environmental_deaths_rated: byte,
    self_kills_rated: byte,
    update_mode: "same_tick_batch",
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

`-1` for a player or kit id means no player/no kit.
