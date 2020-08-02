#include "\x\tmf\addons\chat\script_component.hpp"
/*
 * Name = TMF_chat_fnc_cmndHeal
 * Author = Freddo
 *
 * Syntaxes:
 * #heal          - Heals self
 * #heal <player> - Heals target player
 * #heal all      - Heals everyone
 *
 * Return Value:
 * Void
 *
 * Description:
 * See Syntaxes
 */

IS_CMND_AVAILABLE(GVAR(healUsage),"#heal");

params [["_name", ""]];

switch (toLower _name) do {
    case "": { // Heal self
        if !(isNil "ace_medical_treatment_fnc_fullHeal") then {
            [CURUNIT, CURUNIT] call ace_medical_treatment_fnc_fullHeal;
        };
        CURUNIT setDamage 0;
        systemChat "TMF: Healed";
    };
    case "all": { // Heal everyone
        {
            if !(isNil "ace_medical_treatment_fnc_fullHeal") then {
                [_x, _x] call ace_medical_treatment_fnc_fullHeal;
            };
            _x setDamage 0;
            systemChat "TMF: Healed everyone";

            (FORMAT_1("TMF: Healed by %1", name player)) remoteExecCall ["systemChat", _x];
        } forEach allPlayers;
    };
    default { // Heal target player
        private _target = [_name] call FUNC(findMatch);

        if !(isNull _target) then {
            if !(isNil "ace_medical_treatment_fnc_fullHeal") then {
                [_target, _target] call ace_medical_treatment_fnc_fullHeal;
            };
            _target setDamage 0;
            systemChat FORMAT_1("TMF: Healed %1", name _target);

            (FORMAT_1("TMF: Healed by %1", name player)) remoteExecCall ["systemChat", _target];
        } else {
            systemChat FORMAT_1("TMF Error: No player containing %1, or more than one found.", str _name);
        };
    };
};

