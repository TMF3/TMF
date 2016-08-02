#include "\x\tmf\addons\spectator\script_component.hpp"
params ["_pos"];
private _render = (worldToScreen _pos);
if(count _render > 0 && ((getPosVisual GVAR(camera)) distance _avgpos) <= ((getObjectViewDistance) select 0)) then {
    _render = _render select 0;
    _render = _render > (0 * safezoneW + safezoneX) || _render <= (1 * safezoneW + safezoneX);
} // render maybe
else {
    _render = false;
}; // dont render
_render
