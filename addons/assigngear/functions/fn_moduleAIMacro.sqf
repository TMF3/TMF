#include "\x\tmf\addons\assigngear\script_component.hpp"

/*
 * Name = TMF_assignGear_fnc_moduleAIMacro
 * Author = Head, Nick
 *
 * Arguments:
 * Module function, do not use
 *
 * Return:
 * Nothing
 *
 * Description:
 * Initializes AI gear assignment variables and assigns gear at mission start.
 */


params ["_mode", "_input"];

switch _mode do {
	// Default object init
	case "init": {
        _input params ["_logic", "_isActivated", "_isCuratorPlaced"];

        private ["_config"];
        /*if (isClass (missionConfigFile >> "CfgLoadouts" >> _logic getVariable "TMF_aiGear_faction" >> "AI")) then
        {
            _config = (missionConfigFile >> "CfgLoadouts" >> _logic getVariable "TMF_aiGear_faction" >> "AI");
        }
        else
        {
            _config = (configFile >> "CfgLoadouts" >> _logic getVariable "TMF_aiGear_faction");
        };
        ASSERT_TRUE(isClass _config, "Loadout/macro class does not exist");

        private _side = ((_logic getVariable "TMF_aiGear_side") call BIS_fnc_sideType);

        missionNamespace setVariable [QGVAR(aiGear_) + str _side, _config, true];*/
	};
	// When some attributes were changed (including position and rotation)
	case "attributesChanged3DEN": {
		_logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When added to the world (e.g., after undoing and redoing creation)
	case "registeredToWorld3DEN": {
		_logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// When removed from the world (i.e., by deletion or undoing creation)
	case "unregisteredFromWorld3DEN": {
		_logic = _input param [0,objNull,[objNull]];
		// ... code here...
	};
	// "dragged3DEN" "connectionChanged3DEN"
	default {

	};
};
true
