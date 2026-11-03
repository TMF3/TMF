#include "\x\tmf\addons\adminmenu\script_component.hpp"
private _fnc_settings = {
    [
        QGVAR(printToChat),
        "LIST",
        ["Show admin log in chat", "Which admin log entries are also shown in chat. Only admins see these messages."],
        ["TMF", "Adminmenu"],
        [[2,1,0],["All entries", "Warnings only", "Off"],1]
    ] call CBA_fnc_addSetting;

    [
        QGVAR(endLogToRPT),
        "CHECKBOX",
        ["Save admin log to server RPT at mission end", "When the mission ends, the full admin log is written to the server's RPT file."],
        ["TMF", "Adminmenu"],
        false
    ] call CBA_fnc_addSetting;
};

if is3DEN then _fnc_settings else {
    [{[] call FUNC(isAuthorized) || isServer},_fnc_settings] call CBA_fnc_waitUntilAndExecute;
};


