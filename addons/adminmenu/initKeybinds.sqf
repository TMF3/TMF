["TMF", QGVAR(openKey), ["Open Admin Menu", "Only available for admins and in singleplayer"], FUNC(keyPressed), {false}, [59, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // Shift + F1

if (!isNil "TMF_event_fnc_addEventHandler") then {
    [QEGVAR(spectator,keyDown), {
        params ["", "_args"];
        private _keyPressed = _args select 1;
        private _modifiersPressed = _args select [2, 3];

        private _binding = ["TMF", QGVAR(openKey)] call CBA_fnc_getKeybind;
        if (isNil "_binding") exitWith {};
        _binding = _binding select 5;
        _binding params ["_DIK", "_modifiers"];

        if !(_keyPressed isEqualTo _DIK) exitWith {};
        if !(_modifiersPressed isEqualTo _modifiers) exitWith {};

        call FUNC(keyPressed);
    }] call EFUNC(event,addEventHandler);
};
