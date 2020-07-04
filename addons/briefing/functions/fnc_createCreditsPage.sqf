#include "\x\tmf\addons\briefing\script_component.hpp"

// Ensure mission version is at least 1.0.1
if (!([[1,0,1]] call EFUNC(common,checkTMFVersion))) exitWith {};


// Auto-Create Credits.
private _text = "<br/><font size='20'>" + briefingName + "</font><br/>";

_text = _text + "<font size='14'>by " + getMissionConfigValue ["Author", ""] +"</font><br/><br/><br/>";

_text = _text + "<font size='12'>Terrain: " + getText (configFile >> "CfgWorlds" >> worldName >> "description") + "</font>";


_text = _text + "<br/><br/><font size='12'>This mission was created using TMF (Teamwork Mission Framework).<br/>TMF Mod v" + getText (ConfigFile >> "CfgPatches" >> "tmf_main" >> "versionStr") + "<br/>TMF Mission Template v" + (getMissionConfigValue ["tmf_version",[0,0,0]] joinString ".") + "</font>";

player createDiaryRecord ["Diary", ["Credits", _text]];