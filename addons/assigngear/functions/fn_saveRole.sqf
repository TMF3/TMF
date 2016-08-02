#include "\x\tmf\addons\assignGear\script_component.hpp"
// TODO, tidy up and add aresnal message, move button maybe?

params ["_unit","_className"];
_data = "";
_nl = "
";
_data = _data + format ["class %1 {"+_nl,_className];
_data = _data + format ["    displayName = %1;"+_nl,str "test"];
if(uniform _unit != "") then {
    _data = _data + format ["    uniform[] = {%1};"+_nl,str uniform _unit];
};
if(vest _unit != "") then {
    _data = _data + format ["    vest[] = {%1};"+_nl,str vest _unit];
};
if(backpack _unit != "") then {
    _data = _data + format ["    backpack[] = {%1};"+_nl,str backpack _unit];
};
if(headgear _unit != "") then {
    _data = _data + format ["    headgear[] = {%1};"+_nl,str headgear _unit];
};
if(goggles _unit != "") then {
    _data = _data + format ["    goggles[] = {%1};"+_nl,str goggles _unit];
};
if(hmd _unit != "") then {
    _data = _data + format ["    hmd[] = {%1};"+_nl,str hmd _unit];
};


if(primaryWeapon _unit != "") then {
    _data = _data + format ["    primaryWeapon[] = {%1};"+_nl,str primaryWeapon _unit];
};
if(count primaryWeaponItems _unit > 0) then {
    _data = _data + format ["    primaryWeaponItems[] = %1;"+_nl,[primaryWeaponItems _unit] call CFUNC(arrayToStringArray)];
};

if(secondaryWeapon _unit != "") then {
    _data = _data + format ["    secondaryWeapon[] = {%1};"+_nl,str secondaryWeapon _unit];
};
if(count secondaryWeaponItems _unit > 0) then {
    _data = _data + format ["    secondaryAttachments[] = %1;"+_nl,[secondaryWeaponItems _unit] call CFUNC(arrayToStringArray)];
};
if(handgunWeapon _unit != "") then {
    _data = _data + format ["    sidearmWeapon[] = {%1};"+_nl,str handgunWeapon _unit];
};
if(count handgunItems _unit > 0) then {
    _data = _data + format ["    sidearmAttachments[] = %1;"+_nl,[handgunItems _unit] call CFUNC(arrayToStringArray)];
};

_magazines = magazines _unit;
_items = (vestItems _unit + uniformItems _unit) - _magazines;
if(count _magazines  > 0) then {
    _data = _data + format ["    magazines[] = %1;"+_nl,[_magazines] call CFUNC(arrayToStringArray)];
};

if(count _items  > 0) then {
    _data = _data + format ["    _items[] = %1;"+_nl,[_items] call CFUNC(arrayToStringArray)];
};

if(count assignedItems _unit  > 0) then {
    _data = _data + format ["    linkedItems[] = %1;"+_nl,[assignedItems _unit] call CFUNC(arrayToStringArray)];
};
_data = _data + "};";
copyToClipboard _data;
if(!isNull (uinamespace getvariable ["bis_fnc_arsenal_display",displayNull]) ) then {
    ['showMessage',[(uinamespace getvariable ["bis_fnc_arsenal_display",displayNull]),localize "STR_a3_RscDisplayArsenal_message_clipboard"]] call (uinamespace getvariable "BIS_fnc_arsenal");
//    ['showMessage',[_display,localize "STR_a3_RscDisplayArsenal_message_clipboard"]] call bis_fnc_arsenal;
};
