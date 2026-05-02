scoreboard players set #digit_index sgp.dummy 0
scoreboard players set #is_negative sgp.dummy 0

# The Overflow Trick: Flip negative numbers to positive 31-bit integers
execute if score #current sgp.dummy matches ..-1 run scoreboard players set #is_negative sgp.dummy 1
execute if score #is_negative sgp.dummy matches 1 run scoreboard players add #current sgp.dummy 2147483647
execute if score #is_negative sgp.dummy matches 1 run scoreboard players add #current sgp.dummy 1

# Extract the 8 hex characters for this integer
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit
function sgp.misc:uuid_array_to_string/extract_digit