#include "script_component.hpp"

class cfgPatches
{
    class ADDON
    {
        name = "TMF: Common";
        author = "Nick";
        url = "http://www.teamonetactical.com";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tmf_main","3den"};
        VERSION_CONFIG;
    };
};
#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "display3DEN.hpp"

// Register loadscreens to parsingNamespace
__EXEC(                                                                                      \
    _arr = [];                                                                               \
    for "_i" from 1 to 10 do { _arr pushBack format [QPATHTOF(UI\loadscreens\%1.jpg),_i]; }; \
    GVAR(loadscreens) = _arr;                                                                \
)

class TMF_autotest {
    class GVAR(groupNamesSlottingScreen) {
        code = QUOTE([] call FUNC(testGroupsSlottingScreen));
    };
};
