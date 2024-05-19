scoreboard players operation RandomCalc random_calc *= RandomConstMult random_calc
scoreboard players operation RandomCalc random_calc %= RandomConstMod random_calc
scoreboard players operation RandomCalc random_calc += RandomConstAdd random_calc
scoreboard players operation RandomOut random_calc = RandomCalc random_calc 
scoreboard players operation RandomOut random_calc %= RandomConstOutMod random_calc
scoreboard players operation RandomOut random_calc += RandomConstOutAdd random_calc
scoreboard players operation RandomOutMoins1 random_calc = RandomOut random_calc
scoreboard players operation RandomOutMoins1 random_calc -= 1 test