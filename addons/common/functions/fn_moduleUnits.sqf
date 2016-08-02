params ["_logic"];
private _units = [];
switch (_logic getVariable ["TMFUnits",-1]) do {
    case (-1): {
        _units append allUnits;
    };
    case (0): {
        {
          _units append crew vehicle _x;
        } forEach synchronizedObjects _logic;
    };
    case (1): {
        {
          _units append units _x;
        } foreach synchronizedObjects _logic;
    };
    case (2): {
      {
        private _side = side _x;
        _units append (allUnits select {_side == side _x});
      } forEach synchronizedObjects _logic;
    };
};
_units arrayIntersect _units