#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];
sleep 1;
if(_activated) then {
        [{
            _this params ["_logic"];
            if((getpos player) inArea ([getpos _logic] + (_logic getVariable ["objectArea",[]])) && (player getVariable [QGVAR(rearmHandle),-1]) == -1) then {
                _handle = player addAction ["<t color='#FF0000'>Rearm</t>",{_this call tmf_ai_fnc_rearm},[],6,true,true,"","vehicle player != player && local (vehicle player) && !isEngineOn (vehicle player) && !(player getVariable ['tmf_ai_rearming', false])"];
                player setVariable [QGVAR(rearmHandle), _handle];
            };
            if((player getVariable [QGVAR(rearmHandle),-1]) != -1 && !( (getpos player) inArea ([getpos _logic] + (_logic getVariable ["objectArea",[]])) ) ) then
            {
                player removeAction (player getVariable [QGVAR(rearmHandle),-1]);
                player setVariable [QGVAR(rearmHandle), -1];
            };
        }, 5, _logic] call CBA_fnc_addPerFrameHandler;
};
