# Set the character to a hyphen
data modify storage sgp:data temp.macro_input.char set value "-"

# Copy the current string state into the macro input
data modify storage sgp:data temp.macro_input.string set from storage sgp:data temp.string

# Run the concatenation
function sgp.misc:uuid_array_to_string/concat with storage sgp:data temp.macro_input