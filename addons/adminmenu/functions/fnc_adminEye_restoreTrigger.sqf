#include "\x\tmf\addons\adminmenu\script_component.hpp"

disableSerialization;

params ["_trigger"];

private _data = _trigger getVariable ["tmf_trigger_serialised",[]];

if (count _data == 0) exitWith {};

_data params ["_statements","_delays", "_activation"];

_trigger setTriggerStatements _statements;
_trigger setTriggerTimeout _delays;
_trigger setTriggerActivation _activation;



