params ["_dir"];
["N","NE","E","SE","S","SW","W","NW","N"] select (round ((_dir mod 360) / 45));