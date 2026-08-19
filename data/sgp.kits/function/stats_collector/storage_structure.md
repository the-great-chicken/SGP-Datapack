# `sgp.kits:stats`

```snbt
{
  kits_dict: {
    "<player_id:int>": {
      "<kit_id:int>": {
        ability_use: int,
        kills: {
          "<victim_kit_id:int>": int
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

-1 for a player or kit id is no player/no kit