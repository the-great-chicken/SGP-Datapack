# Grab the correct letter/number from our constant array
$data modify storage sgp:data temp.macro_input.char set from storage sgp:data const.hex[$(digit)]

# Copy the running string into the macro input so we can prepend to it
data modify storage sgp:data temp.macro_input.string set from storage sgp:data temp.string
function sgp.misc:uuid_array_to_string/concat with storage sgp:data temp.macro_input