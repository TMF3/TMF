#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_pos"];
private _render = false;

private _screenPos = worldToScreen _pos;
if(count _screenPos > 0 && {((getPosVisual GVAR(camera)) distance _pos) <= ((getObjectViewDistance) select 0)}) then {
    _screenPos params ["_x","_y"];
    _render = _x > (0 * safeZoneW + safeZoneX) && {_x <= (1 * safeZoneW + safeZoneX)} && {_y > (0 * safeZoneH + safeZoneY)} && {_y <= (1 * safeZoneH + safeZoneY)};
}; // render maybe
_render
