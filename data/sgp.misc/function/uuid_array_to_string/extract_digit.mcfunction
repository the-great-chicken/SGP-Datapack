# Insert the standard UUID hyphens at the correct character marks
execute if score #global_digit_index sgp.dummy matches 12 run function sgp.misc:uuid_array_to_string/insert_hyphen
execute if score #global_digit_index sgp.dummy matches 16 run function sgp.misc:uuid_array_to_string/insert_hyphen
execute if score #global_digit_index sgp.dummy matches 20 run function sgp.misc:uuid_array_to_string/insert_hyphen
execute if score #global_digit_index sgp.dummy matches 24 run function sgp.misc:uuid_array_to_string/insert_hyphen

# Modulo by 16 to get the lowest digit
scoreboard players operation #digit sgp.dummy = #current sgp.dummy
scoreboard players operation #digit sgp.dummy %= 16 sgp.dummy

# Restore the missing 32nd bit (add 8) if this is the final digit of a negative number
execute if score #digit_index sgp.dummy matches 7 if score #is_negative sgp.dummy matches 1 run scoreboard players add #digit sgp.dummy 8

# Store the digit (0-15) and trigger the lookup macro
execute store result storage sgp:data temp.macro_input.digit int 1 run scoreboard players get #digit sgp.dummy
function sgp.misc:uuid_array_to_string/get_char with storage sgp:data temp.macro_input

# Divide by 16 to shift to the next digit, and increment our loop counters
scoreboard players operation #current sgp.dummy /= 16 sgp.dummy
scoreboard players add #digit_index sgp.dummy 1
scoreboard players add #global_digit_index sgp.dummy 1