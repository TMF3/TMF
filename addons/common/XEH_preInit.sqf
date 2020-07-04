#include "\x\tmf\addons\common\script_component.hpp"

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

if is3DEN call {
    call FUNC(edenInit);
};

isTMF = ((getMissionConfigValue ["tmf_version",[0,0,0]] select 0) > 0);
