#> Summons a dummy and test for each kit if it can be obtained without unlocking it
# @dummy

function sgp.kits:check_and_give {kit:"pyromane", kit_name:"Pyromane", kit_color:gold, hint:"Salle de Lave", hint_color:"#ffba00"}
assert not entity @s[nbt={Inventory:[{}]}]