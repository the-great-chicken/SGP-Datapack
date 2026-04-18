#> sgp.mineurs:lootdrop/build_fallback_name
# `{item_id_dot: "minecraft.diamond_sword"}`

$data modify storage sgp:macro item_name set value [{"translate": "item.$(item_id_dot)", "fallback": ""}, {"translate": "block.$(item_id_dot)", "fallback": ""}]