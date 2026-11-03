#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];
//Group count check.
{
    private _side = _x;
    private _groupCount = _side countSide allGroups;
    if (_groupCount > 200) then {
        _output pushBack [1,format["Side %1 has %2 groups. Arma allows at most 288 groups per side; new groups fail to spawn past that.",_side,_groupCount]];
    }
} forEach [west,east,civilian,resistance];

_output
