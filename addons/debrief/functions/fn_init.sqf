#include "\x\tmf\addons\debrief\script_component.hpp"

GVAR(allunits) = allunits + vehicles;
GVAR(monitorSides) = [blufor,opfor,independent,civilian];
GVAR(destroyedUnits) = [];
addMissionEventHandler ["EntityKilled",{
    params ["_killed","_killer"];
    if(_killed in GVAR(allunits)) then {
      GVAR(destroyedUnits) pushback [typeof _killed,_killed getVariable [QGVAR(side),sideEmpty]];
    }
  }];
while {true} do {
    GVAR(allunits) = GVAR(allunits) + (GVAR(allunits) - (allunits+vehicles));
    {
      private _side = side _x;
      if(_side in GVAR(monitorSides)) then {
        // dont allow vehicles to go from any to civilian
        if(_side != civilian || (_x getVariable [QGVAR(side),_side]) == _side) then {
          _x setVariable [QGVAR(side), _side]
        };
      };
    } foreach GVAR(allunits);
    sleep 3;
};
