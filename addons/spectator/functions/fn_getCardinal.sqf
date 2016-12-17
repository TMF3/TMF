params ["_dir"];
if(_dir > 360) then {_dir = abs(360-_dir)};
if(_dir < 0) then {_dir = 360+_dir};
["N","NE","E","SE","S","SW","W","NW","N"] select (round ((_dir mod 360) / 45));