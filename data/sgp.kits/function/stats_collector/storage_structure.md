# `sgp.kits:stats`

```snbt
{
  schema_version: 2,
  damage_cause_names: {
    "<cause_id:int>": string
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

Ability values are lazy: a stored field is absent until its first increment. The
metadata is authoritative for names, meanings, units, display scaling, timing,
and whether a metric is stored or derived. In particular, Cancer's
`bat_explosion_damage` is derived from `damage_received` and is not duplicated
under `abilities.bats`.

Damage values use the same integer convention as `damage_received`: tenths of a
heart. Only positive health damage received by players tagged `sgp.in_game` is
recorded. `pick.last_pick` exists transiently during a life and is removed when
that life is finalized.
