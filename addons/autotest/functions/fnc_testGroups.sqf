#include "\x\tmf\addons\autotest\script_component.hpp"

private _output = [];
//Group count check.
{
    private _side = _x;
    private _groupCount = {(side _x isEqualTo _side)} count allGroups;
    if (_groupCount > 200) then {
        _output pushBack [1,format["Side %1 has %2 groups. Note Arma has a 288 group limit per side.",_side,_groupCount]];
    }
} forEach [west,east,civilian,resistance];

_output
