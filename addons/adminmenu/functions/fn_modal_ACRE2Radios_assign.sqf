#include "\x\tmf\addons\adminmenu\script_component.hpp"

params [["_radios", []], ["_network", -1]];

systemChat format ["_radios:%1, _network:%2", str _radios, _network];

private _newPreset = if (_network > -1) then {
	format ["tmf_preset%1", _network]
} else {
	""
};

[{
	params ["_args", "_pfh"];
	_args params ["_radios", "_newPreset"];

	if (_radios isEqualTo []) exitWith {
		[_pfh] call CBA_fnc_removePerFrameHandler;
	};

	private _radio = _radios deleteAt 0;

	if (player canAdd _radio) then {
		private _oldPreset = [_radio] call acre_api_fnc_getPreset;
		private _switchPreset = !(_newPreset isEqualTo "" || _newPreset isEqualTo _oldPreset);

		if (_switchPreset) then {
			systemChat format ["%1 used new preset %2", _radio, _newPreset];

			[_radio, _newPreset] call acre_api_fnc_setPreset;
			player addItem _radio;

			[{ // not sure i need to do this
				params ["_radio", "_oldPreset"];
				[_radio, _oldPreset] call acre_api_fnc_setPreset;
			}, 0.1, [_radio, _oldPreset]] call CBA_fnc_waitAndExecute;
		} else {
			systemChat format ["%1 used old preset %2", _radio, _oldPreset];

			player addItem _radio;
		};
	} else {
		systemChat format ["cant add %1", _radio];
	};
}, 0, [+_radios, _newPreset]] call CBA_fnc_addPerFrameHandler;