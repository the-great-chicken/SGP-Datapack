#> sgp.bench:scenarios/abilities/tnt_batting/setup
# `{first: int, last: int, players: int, period: int, bat_delay: int}`

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"pyromane"}
$function sgp.bench:scenarios/abilities/tnt_batting/fire {first:$(first),last:$(last),players:$(players)}
