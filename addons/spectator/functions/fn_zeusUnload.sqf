waitUntil {!dialog};
if(isNil "bis_fnc_moduleRemoteControl_unit") then {
  createDialog "tmf_spectator_dialog";
} else {
    waitUntil {sleep 0.1;isNil "bis_fnc_moduleRemoteControl_unit"};
    waitUntil {sleep 0.1;!isNull (findDisplay 312)}; // wait until open
    (findDisplay 312) displayAddEventHandler ["Unload",{_this call tmf_spectator_fnc_zeusUnload;}];
};
